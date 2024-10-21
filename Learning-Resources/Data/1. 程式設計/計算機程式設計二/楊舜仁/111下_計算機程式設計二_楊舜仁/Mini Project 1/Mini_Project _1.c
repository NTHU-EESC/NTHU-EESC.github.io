/************

這份code在上機考時會有超出記憶體用量的問題，
解決辦法就是將算好的東西從暫存器放回記憶體，
要用再拿出來用就好。
祝 上機順利~~~

************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>


// for lex
#define MAXLEN 256

// Token types
typedef enum {
    UNKNOWN, END, ENDFILE,
    INT, ID,
    ADDSUB, MULDIV,
    ASSIGN,
    LPAREN, RPAREN,
    AND, OR, XOR,
    INCDEC, ADDSUB_ASSIGN
} TokenSet;

TokenSet getToken(void);
TokenSet curToken = UNKNOWN;
char lexeme[MAXLEN];
int divzero_err = 0;

// Test if a token matches the current token
int match(TokenSet token);
// Get the next token
void advance(void);
// Get the lexeme of the current token
char *getLexeme(void);


// for parser
#define TBLSIZE 64
// Set PRINTERR to 1 to print error message while calling error()
// Make sure you set PRINTERR to 0 before you submit your code
#define PRINTERR 1

// Call this macro to print error message and exit the program
// This will also print where you called it in your program
#define error(errorNum) { \
    if (PRINTERR) \
        fprintf(stderr, "error() called at %s:%d: ", __FILE__, __LINE__); \
    err(errorNum); \
}

// Error types
typedef enum {
    UNDEFINED, MISPAREN, NOTNUMID, NOTFOUND, RUNOUT, NOTLVAL, DIVZERO, SYNTAXERR
} ErrorType;

// Structure of the symbol table
typedef struct {
    int val;
    char name[MAXLEN];
} Symbol;

// Structure of a tree node
typedef struct _Node {
    TokenSet data;
    int val;
    char lexeme[MAXLEN];
    struct _Node *left;
    struct _Node *right;
} BTNode;

int sbcount = 0;
Symbol table[TBLSIZE];
int register_status[8] = {0};

// Initialize the symbol table with builtin variables
void initTable(void);
// Make a new node according to token type and lexeme
BTNode *makeNode(TokenSet tok, const char *lexe);
// Free the syntax tree
void freeTree(BTNode *root);
BTNode *factor(void);
BTNode* unary_expr();
BTNode* muldiv_expr_tail(BTNode* left);
BTNode* muldiv_expr();
BTNode* addsub_expr_tail(BTNode* left);
BTNode* addsub_expr();
BTNode* and_expr_tail(BTNode* left);
BTNode* and_expr();
BTNode* xor_expr_tail(BTNode* left);
BTNode* xor_expr();
BTNode* or_expr_tail(BTNode* left);
BTNode* or_expr();
BTNode *assign_expr(void);
void statement(void);
// Print error message and exit the program
void err(ErrorType errorNum);


// for codeGen
// Evaluate the syntax tree
int evaluateTree(BTNode *root);


/*============================================================================================
lex implementation
============================================================================================*/

TokenSet getToken(void) {
    int i = 0;
    char c = '\0';

    while ((c = fgetc(stdin)) == ' ' || c == '\t');

    if (isdigit(c)) {
        lexeme[0] = c;
        c = fgetc(stdin);
        i = 1;
        while (isdigit(c) && i < MAXLEN) {
            lexeme[i] = c;
            ++i;
            c = fgetc(stdin);
        }
        ungetc(c, stdin);
        lexeme[i] = '\0';
        return INT;
    }
	else if (c == '+' || c == '-') {
        lexeme[0] = c;
        lexeme[1] = '\0';
		/*different*/
        c = fgetc(stdin);
        if (c == '+' || c == '-') {
            lexeme[1] = c;
            lexeme[2] = '\0';
            return INCDEC;
        } else if (c == '=') {
            lexeme[1] = c;
            lexeme[2] = '\0';
            return ADDSUB_ASSIGN;
        }
        else {
            ungetc(c, stdin);
            return ADDSUB;
        }
    }
	else if (c == '*' || c == '/') {
        lexeme[0] = c;
        lexeme[1] = '\0';
        return MULDIV;
    }
	else if (c == '\n') {
        lexeme[0] = '\0';
        return END;
    }
	else if (c == '=') {
        strcpy(lexeme, "=");
        return ASSIGN;
    }
	else if (c == '(') {
        strcpy(lexeme, "(");
        return LPAREN;
    }
	else if (c == ')') {
        strcpy(lexeme, ")");
        return RPAREN;
    }
	/*different*/
	else if (isalpha(c) || c == '_') {
        int i = 0;
        while (isalpha(c) || isdigit(c) || c == '_') {
            lexeme[i] = c;
            lexeme[i + 1] = '\0';
            c = fgetc(stdin);
            i++;
        }
        ungetc(c, stdin);
        return ID;
    }
	else if (c == EOF) {
        return ENDFILE;
    }
	/*different*/
	else if (c == '&') {
        strcpy(lexeme, "&");
        return AND;
    }
	/*different*/
	else if (c == '|') {
        strcpy(lexeme, "|");
        return OR;
    }
	/*different*/
	else if (c == '^') {
        strcpy(lexeme, "^");
        return XOR;
    }
	else {
        return UNKNOWN;
    }
}

void advance(void) {
    curToken = getToken();
}

int match(TokenSet token) {
    if (curToken == UNKNOWN)
        advance();
    return token == curToken;
}

char *getLexeme(void) {
    return lexeme;
}


/*============================================================================================
parser implementation
============================================================================================*/

void initTable(void) {
    strcpy(table[0].name, "x");
    table[0].val = 0;
    strcpy(table[1].name, "y");
    table[1].val = 0;
    strcpy(table[2].name, "z");
    table[2].val = 0;
    sbcount = 3;
}

BTNode *makeNode(TokenSet tok, const char *lexe) {
    BTNode *node = (BTNode*) malloc(sizeof(BTNode));
    strcpy(node->lexeme, lexe);
    node->data = tok;
    node->val = 0;
    node->left = NULL;
    node->right = NULL;
    return node;
}

void freeTree(BTNode *root) {
    if (root != NULL) {
        freeTree(root->left);
        freeTree(root->right);
        free(root);
    }
}

// factor := INT | ID | INCDEC ID | LPAREN assign_expr RPAREN
BTNode *factor(void) {
    BTNode *retp = NULL, *left = NULL;
    if (match(INT)) {
        retp = makeNode(INT, getLexeme());
        advance();
    }
    else if (match(ID)) {
        retp = makeNode(ID, getLexeme());
		/*check if the ID exists*/
        int flag = 0;
        for (int i = 0; i < sbcount; i++) {
            if (strcmp(retp->lexeme, table[i].name) == 0) {
                flag = 1;
                break;
            }
        }
        if (!flag) {
            printf("EXIT 1\n");
            err(NOTFOUND);
        }
		/************************/
        advance();
    }
    else if (match(INCDEC)) {
        retp = makeNode(INCDEC, getLexeme());
        retp->right = makeNode(INT, "1");
        advance();
        if (match(ID)) {
            retp->left = makeNode(ID, getLexeme());
            advance();
        }
        else {
            printf("EXIT 1\n");
            err(NOTNUMID);
        }
    }
    else if (match(LPAREN)) {
        advance();
        retp = assign_expr();
        if (match(RPAREN)) advance();
        else{
            printf("EXIT 1\n");
            err(MISPAREN);
        }
    }
    else {
        printf("EXIT 1\n");
        err(NOTNUMID);
    }
    return retp;
}

// unary_expr := ADDSUB unary_expr | factor
// ADDSUB for positive or negative
BTNode* unary_expr() {
    BTNode* node = NULL;
    if (match(ADDSUB)) {
        node = makeNode(ADDSUB, getLexeme());
        node->left = makeNode(INT, "0");
        advance();
        node->right = unary_expr();
    }
    else {
        node = factor();
    }
    return node;
}

// muldiv_expr_tail := MULDIV unary_expr muldiv_expr_tail | NiL
BTNode* muldiv_expr_tail(BTNode* left) {
    BTNode* node = NULL;
    if (match(MULDIV)) {
        node = makeNode(MULDIV, getLexeme());
        node->left = left;
        advance();
        node->right = unary_expr();
        return muldiv_expr_tail(node);
    }
    else {
        return left;
    }
}

// muldiv_expr := unary_expr muldiv_expr_tail
BTNode* muldiv_expr() {
    BTNode* node = unary_expr();
    return muldiv_expr_tail(node);
}

// addsub_expr_tail := ADDSUB muldiv_expr addsub_expr_tail | NiL
BTNode* addsub_expr_tail(BTNode* left) {
    BTNode* node = NULL;
    if (match(ADDSUB)) {
        node = makeNode(ADDSUB, getLexeme());
        node->left = left;
        advance();
        node->right = muldiv_expr();
        return addsub_expr_tail(node);
    }
    else {
        return left;
    }
}

// addsub_expr := muldiv_expr addsub_expr_tail
BTNode* addsub_expr() {
    BTNode* node = muldiv_expr();
    return addsub_expr_tail(node);
}

// and_expr_tail := AND addsub_expr and_expr_tail | NiL
BTNode* and_expr_tail(BTNode* left) {
    BTNode* node = NULL;
    if (match(AND)) {
        node = makeNode(AND, getLexeme());
        node->left = left;
        advance();
        node->right = addsub_expr();
        return and_expr_tail(node);
    }
    else {
        return left;
    }
}

// and_expr := addsub_expr and_expr_tail
BTNode* and_expr() {
    BTNode* node = addsub_expr();
    return and_expr_tail(node);
}

// xor_expr_tail := XOR and_expr xor_expr_tail | NiL
BTNode* xor_expr_tail(BTNode* left) {
    BTNode* node = NULL;
    if (match(XOR)) {
        node = makeNode(XOR, getLexeme());
        node->left = left;
        advance();
        node->right = and_expr();
        return xor_expr_tail(node);
    }
    else {
        return left;
    }
}

// xor_expr := and_expr xor_expr_tail
BTNode* xor_expr() {
    BTNode* node = and_expr();
    return xor_expr_tail(node);
}

// or_expr_tail := OR xor_expr or_expr_tail | NiL
BTNode* or_expr_tail(BTNode* left) {
    BTNode* node = NULL;
    if (match(OR)) {
        node = makeNode(OR, getLexeme());
        node->left = left;
        advance();
        node->right = xor_expr();
        return or_expr_tail(node);
    }
    else {
        return left;
    }
}


// or_expr := xor_expr or_expr_tail
BTNode* or_expr() {
    BTNode* node = xor_expr();
    return or_expr_tail(node);
}

// assign_expr := ID ASSIGN assign_expr | ID ADDSUB_ASSIGN assign_expr | or_expr
BTNode *assign_expr(void) {
    BTNode* node = NULL, * left = NULL;
    if (match(ID)) {
        left = makeNode(ID, getLexeme());

		/*for or_expr()*/
        char tmp_id[MAXLEN];
        strcpy(tmp_id, getLexeme());
		/***************/
		
        advance();
        if (match(ASSIGN)) {

			// check if the ID exists
            int flag = 0;
            for (int i = 0; i < sbcount; i++) {
                if (strcmp(left->lexeme, table[i].name) == 0) {
                    flag = 1;
                    break;
                }
            }
			
            // new variable
            if(!flag) {
                table[sbcount].val = sbcount; // 我的寫法不會用到這個變數
                strcpy(table[sbcount].name, left->lexeme);
                sbcount++;
            }

            node = makeNode(ASSIGN, getLexeme());
            node->left = left;
            advance();
            node->right = assign_expr();
        }
        else if (match(ADDSUB_ASSIGN)) {
            node = makeNode(ADDSUB_ASSIGN, getLexeme());
            node->left = left;
            advance();
            node->right = assign_expr();
        }
		// for the most right ID
        else if (match(END)) {
            // check if the ID exists
            int flag = 0;
            for (int i = 0; i < sbcount; i++) {
                if (strcmp(left->lexeme, table[i].name) == 0) {
                    flag = 1;
                    break;
                }
            }
            if(!flag) {
                printf("EXIT 1\n");
                err(NOTFOUND);
            }

            else node = left;
        }
		
		// for x = y = z = ... = expr(start with ID)
        else {
            char tmp[MAXLEN] = {0};
            strcpy(tmp, getLexeme());
            int tmp_len = strlen(tmp);
            for (int i = tmp_len - 1; i >= 0; i--) {
                ungetc(tmp[i], stdin);
            }
            strcpy(lexeme, tmp_id);
            curToken = ID; // important
            node = or_expr();
        }
    }
    else {
        node = or_expr();
    }
    return node;
}

// statement := ENDFILE | END | assign_expr END
void statement(void) {
    BTNode *retp = NULL;

    if (match(ENDFILE)) {
		printf("MOV r0 [0]\n");
		printf("MOV r1 [4]\n");
		printf("MOV r2 [8]\n");
		printf("EXIT 0\n");
        exit(0);
    }
	else if (match(END)) {
        advance();
    }
	else {
        // initialize register status for every statement
        memset(register_status, 0, sizeof(register_status));
        divzero_err = 0;
		
        retp = assign_expr();
		
        if (match(END)) {
            evaluateTree(retp);
            /*printf("MOV r0 [0]\n");
            printf("MOV r1 [4]\n");
            printf("MOV r2 [8]\n");*/

            freeTree(retp);
            advance();
        }
		else {
            printf("EXIT 1\n");
            err(SYNTAXERR);
        }
    }
}

void err(ErrorType errorNum) {
    if (PRINTERR) {
        fprintf(stderr, "error: ");
        switch (errorNum) {
            case MISPAREN:
                fprintf(stderr, "mismatched parenthesis\n");
                break;
            case NOTNUMID:
                fprintf(stderr, "number or identifier expected\n");
                break;
            case NOTFOUND:
                fprintf(stderr, "variable not defined\n");
                break;
            case RUNOUT:
                fprintf(stderr, "out of memory\n");
                break;
            case NOTLVAL:
                fprintf(stderr, "lvalue required as an operand\n");
                break;
            case DIVZERO:
                fprintf(stderr, "divide by constant zero\n");
                break;
            case SYNTAXERR:
                fprintf(stderr, "syntax error\n");
                break;
            default:
                fprintf(stderr, "undefined error\n");
                break;
        }
    }
    exit(0);
}


/*============================================================================================
codeGen implementation
============================================================================================*/

// check the value of the divisor
int divzero_check(BTNode* root) {
    if (divzero_err) return 0;
    if (root != NULL) {
        switch (root->data) {
            case ID:
                divzero_err = 1;
                return 0;
                break;

            case INT:
                return atoi(root->lexeme);
                break;

            case ADDSUB:
                if (strcmp(root->lexeme, "+") == 0)
                    return divzero_check(root->left) + divzero_check(root->right);
                    
                else if (strcmp(root->lexeme, "-") == 0)
                    return divzero_check(root->left) - divzero_check(root->right);
				
                break;

            case MULDIV:
                if (strcmp(root->lexeme, "*") == 0)
                    return divzero_check(root->left) * divzero_check(root->right);
					
                else {
                    int l = divzero_check(root->left);
                    int r = divzero_check(root->right);
                    if (r == 0 && !divzero_err) {
                        printf("EXIT 1\n");
                        err(DIVZERO);
                    }
                    else if (r == 0) return 0;
                    return l / r;
                }
				
                break;

            case AND:
                return divzero_check(root->left) & divzero_check(root->right);
                break;

            case OR:
                return divzero_check(root->left) | divzero_check(root->right);
                break;

            case XOR:
                return divzero_check(root->left) ^ divzero_check(root->right);
                break;

            case INCDEC:
                if (strcmp(root->lexeme, "++") == 0)
                    return divzero_check(root->left) + divzero_check(root->right);
					
                else if (strcmp(root->lexeme, "--") == 0)
                    return divzero_check(root->left) - divzero_check(root->right);
				
                break;
            
            case ADDSUB_ASSIGN:
                if (strcmp(root->lexeme, "+=") == 0)
                    return divzero_check(root->left) + divzero_check(root->right);
					
                else if (strcmp(root->lexeme, "-=") == 0)
                    return divzero_check(root->left) - divzero_check(root->right);
				
                break;

            default:
                return 0;
        }
    }
    return 0;
}

int evaluateTree(BTNode *root) {

    int lv = 0, rv = 0, ret_register = -1;

	/*If ret_register is -1 finally, it is an error condition*/

    if (root != NULL) {
        switch (root->data) {
            case ID:
                for (int i = 0; i < sbcount; i++) {
                    if (strcmp(table[i].name, root->lexeme) == 0) {
                        for (int j = 0; j < 8; j++) {
                            if (!register_status[j]) {
                                printf("MOV r%d [%d]\n", j, i * 4);
                                register_status[j] = 1;
                                ret_register = j;
                                break;
                            }
                        }
                        break;
                    }
                }
                if (ret_register == -1) {
                    printf("EXIT 1\n");
                    err(NOTNUMID);
                }
                break;
			
            case INT:
                for (int i = 0; i < 8; i++) {
                    if (!register_status[i]) {
                        printf("MOV r%d %d\n", i, atoi(root->lexeme));
                        register_status[i] = 1;
                        ret_register = i;
                        break;
                    }
                }
                if (ret_register == -1) {
                    printf("EXIT 1\n");
                    err(RUNOUT);
                }
                break;

            case ASSIGN:
                rv = evaluateTree(root->right);
                for (int i = 0; i < sbcount; i++) {
                    if (strcmp(table[i].name, root->left->lexeme) == 0) {
                        printf("MOV [%d] r%d\n", i * 4, rv);
                        ret_register = rv; // for multiple assign
                        break;
                    }
                }
                if (ret_register == -1) {
                    printf("EXIT 1\n");
                    err(SYNTAXERR);
                }
                break;

            case ADDSUB:
                lv = evaluateTree(root->left);
                rv = evaluateTree(root->right);
                if (strcmp(root->lexeme, "+") == 0) {
                    printf("ADD r%d r%d\n", lv, rv);
                    register_status[rv] = 0;
                    ret_register = lv;
                }
                else if (strcmp(root->lexeme, "-") == 0) {
                    printf("SUB r%d r%d\n", lv, rv);
                    register_status[rv] = 0;
                    ret_register = lv;
                }
                if (ret_register == -1) {
                    printf("EXIT 1\n");
                    err(SYNTAXERR);
                }
                break;

            case MULDIV:
                lv = evaluateTree(root->left);
                rv = evaluateTree(root->right);
                if (strcmp(root->lexeme, "*") == 0) {
                    printf("MUL r%d r%d\n", lv, rv);
                    register_status[rv] = 0;
                    ret_register = lv;
                }
                else if (strcmp(root->lexeme, "/") == 0) {
                    // divzero error handle
					// check the divisor
                    int tmp_err = divzero_check(root->right);
                    if (!tmp_err && !divzero_err) {
                        printf("EXIT 1\n");
                        err(DIVZERO);
                    }
                    printf("DIV r%d r%d\n", lv, rv);
                    register_status[rv] = 0;
                    ret_register = lv;
                }
                if (ret_register == -1) {
                    printf("EXIT 1\n");
                    err(SYNTAXERR);
                }
                break;

            case AND:
                lv = evaluateTree(root->left);
                rv = evaluateTree(root->right);
                printf("AND r%d r%d\n", lv, rv);
                register_status[rv] = 0;
                ret_register = lv;
                if (ret_register == -1) {
                    printf("EXIT 1\n");
                    err(SYNTAXERR);
                }
                break;

            case OR:
                lv = evaluateTree(root->left);
                rv = evaluateTree(root->right);
                printf("OR r%d r%d\n", lv, rv);
                register_status[rv] = 0;
                ret_register = lv;
                if (ret_register == -1) {
                    printf("EXIT 1\n");
                    err(SYNTAXERR);
                }
                break;

            case XOR:
                lv = evaluateTree(root->left);
                rv = evaluateTree(root->right);
                printf("XOR r%d r%d\n", lv, rv);
                register_status[rv] = 0;
                ret_register = lv;
                if (ret_register == -1) {
                    printf("EXIT 1\n");
                    err(SYNTAXERR);
                }
                break;

            // special case
            case INCDEC:
                rv = evaluateTree(root->right);
                lv = evaluateTree(root->left);
                if (strcmp(root->lexeme, "++") == 0) {
                    for (int i = 0; i < sbcount; i++) {
                        if (strcmp(table[i].name, root->left->lexeme) == 0) {
                            printf("ADD r%d r%d\n", lv, rv);
                            printf("MOV [%d] r%d\n", i * 4, lv);
                            register_status[rv] = 0;
                            ret_register = lv;
                            break;
                        }
                    }
                }
                else if (strcmp(root->lexeme, "--") == 0) {
                    for (int i = 0; i < sbcount; i++) {
                        if (strcmp(table[i].name, root->left->lexeme) == 0) {
                            printf("SUB r%d r%d\n", lv, rv);
                            printf("MOV [%d] r%d\n", i * 4, lv);
                            register_status[rv] = 0;
                            ret_register = lv;
                            break;
                        }
                    }
                }
				if (ret_register == -1) {
					printf("EXIT 1\n");
					err(SYNTAXERR);
				}
                break;
            
            case ADDSUB_ASSIGN:
                rv = evaluateTree(root->right);
                lv = evaluateTree(root->left);
                if (strcmp(root->lexeme, "+=") == 0) {
                    for (int i = 0; i < sbcount; i++) {
                        if (strcmp(table[i].name, root->left->lexeme) == 0) {
                            printf("ADD r%d r%d\n", lv, rv);
                            printf("MOV [%d] r%d\n", i * 4, lv);
                            register_status[rv] = 0;
                            ret_register = lv;
                            break;
                        }
                    }
                }
                else if (strcmp(root->lexeme, "-=") == 0) {
                    for (int i = 0; i < sbcount; i++) {
                        if (strcmp(table[i].name, root->left->lexeme) == 0) {
                            printf("SUB r%d r%d\n", lv, rv);
                            printf("MOV [%d] r%d\n", i * 4, lv);
                            register_status[rv] = 0;
                            ret_register = lv;
                            break;
                        }
                    }
                }
				if (ret_register == -1) {
					printf("EXIT 1\n");
					err(SYNTAXERR);
				}
                break;

            default:
                ret_register = -1;
                printf("EXIT 1\n");
                err(SYNTAXERR);
        }
    }
    
    return ret_register;
}


/*============================================================================================
main
============================================================================================*/

int main() {
    // freopen("input.txt", "w", stdout);
    initTable();
    while (1) {
        statement();
    }
    return 0;
}
