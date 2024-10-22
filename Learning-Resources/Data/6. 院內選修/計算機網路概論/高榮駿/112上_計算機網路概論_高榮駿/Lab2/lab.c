#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <unistd.h>
#include <netinet/in.h>
#include <netdb.h>

#define BUFFER_SIZE 103424
#define PORT 80

void getResponse(FILE* log);
void getHtml(FILE* log);
void getRidOfComment(FILE* log);
void getHref(FILE* log);
void outputToTerminal(FILE* log);

int main() {
	FILE* log = fopen("log.txt", "w");

	getResponse(log);
	getHtml(log);
	// getRidOfComment(log);
	getHref(log);
	outputToTerminal(log);


	fclose(log);
	return 0; 

} 

void getResponse(FILE* log) {

	fprintf(log, "running getResponse()\n");

	FILE* responseFile = fopen("responseFile.txt", "w");
	FILE* socketFile = fopen("socketFile.txt", "w");
	char hostName[1000] = {0}, path[1000] = {0};
	char c;
	int isHost = 1;
	int idx = 0;

	fprintf(socketFile, "========== Socket ==========\n");

	printf("Please enter the URL:\n");
	while (1) {
		c = getchar();
		if (c == '\n' || c == EOF) break;
		else if (isHost) {
			if (c == '/') {
				path[0] = '/';
				isHost = 0;
				idx = 1;
			}
			else hostName[idx++] = c;
		}
		else path[idx++] = c;
	}

	fprintf(log, "Host Name: %s\n", hostName);
	fprintf(log, "Path: %s\n", path);

	struct hostent* entry = gethostbyname(hostName);
	char* IP_address = inet_ntoa(*((struct in_addr *) entry->h_addr_list[0]));

	fprintf(log, "IP: %s\n", IP_address);

	int sockfd;
	struct sockaddr_in server_addr;
	socklen_t addrlen = sizeof(server_addr);
	char message[2048] = {0}; 
	unsigned char buffer[BUFFER_SIZE] = {'\0'};

	server_addr.sin_family = AF_INET;
	server_addr.sin_addr.s_addr = inet_addr(IP_address);
	server_addr.sin_port = htons(PORT);

	// create a socket, return -1 if fail
	if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
		perror("socket()");
		exit(EXIT_FAILURE);
	}
	if (connect(sockfd, (struct sockaddr *)&server_addr, addrlen) == -1) {
		perror("connect()");
		fprintf(stderr, "Please start the server first\n");
		exit(EXIT_FAILURE);
	} 
	fprintf(log, "Connected to server\n");

	memset(message, 0, sizeof(message));
	strcpy(message + strlen(message), "GET /");
	strcpy(message + strlen(message), path);
	strcpy(message + strlen(message), " HTTP/1.1\r\nHost: ");
	strcpy(message + strlen(message), hostName);
	strcpy(message + strlen(message), "\r\nConnection: close\r\n\r\n");

	send(sockfd, message, strlen(message), 0);
	fprintf(log, "HTTP request sent\n\n");
	fprintf(socketFile, "Senging HTTP request\n");

	while (recv(sockfd, buffer, BUFFER_SIZE, 0) > 0) {
		fprintf(responseFile, "%s", buffer);
		memset(buffer, 0, sizeof(buffer));
	}
	fprintf(responseFile, "\n");   
	fprintf(log, "recieve html file\n"); 
	fprintf(socketFile, "Recieving the response\n");

	close(sockfd);
	fclose(responseFile);
	fclose(socketFile);
}

void getHtml(FILE* log) {

	fprintf(log, "running getHtml()\n");

	FILE* responseFile = fopen("responseFile.txt", "r");
	FILE* htmlFile = fopen("htmlFile.txt", "w");

	char c, start = 0;
	while (~fscanf(responseFile, "%c", &c)) {
		if (c == '<') start = 1;
		if (start) fprintf(htmlFile, "%c", c);
	}

	fclose(responseFile);
	fclose(htmlFile);
}

void getRidOfComment(FILE* log) {

	fprintf(log, "running getRidOfComment()\n");

	FILE* htmlFile = fopen("htmlFile.txt", "r");
	FILE* htmlFileWithoutComment = fopen("htmlFileWithoutComment.txt", "w");

	char c, buffer[BUFFER_SIZE], output[BUFFER_SIZE];
	int len = 0, outputLen = 0;

	memset(buffer, 0, sizeof(buffer));
	while (~fscanf(htmlFile, "%c", &c)) {
		buffer[len++] = c;
	}

	char* cursor = buffer;

	memset(output, 0, sizeof(output));

	char* commentHead, * commentTail;

	while ((commentHead = strstr(cursor, "<!--"))) {
		commentTail = strstr(commentHead, "-->");
		strncpy(output + outputLen, cursor, commentHead - cursor);
		outputLen += commentHead - cursor;
		cursor = commentTail + strlen("-->");
	}

	strcpy(output + outputLen, cursor);

	fprintf(htmlFileWithoutComment, "%s", output);

	fclose(htmlFile);
	fclose(htmlFileWithoutComment);

}

void getHref(FILE* log) {

	fprintf(log, "running getHref()\n");

	FILE* htmlFileWithoutComment = fopen(/*"htmlFileWithoutComment.txt"*/"htmlFile.txt", "r");
	FILE* hrefFile = fopen("hrefFile.txt", "w");

	char c, buffer[BUFFER_SIZE], output[BUFFER_SIZE];
	int len = 0, outputLen = 0;

	memset(buffer, 0, sizeof(buffer));
	while (~fscanf(htmlFileWithoutComment, "%c", &c)) {
		buffer[len++] = c;
	}

	char* cursor = buffer;

	memset(output, 0, sizeof(output));

	char* aHead, * aTail, *aClose, * hrefHead, * hrefTail;

	int totalHref = 0;

	while ((aHead = strstr(cursor, "<a"))) {
		aTail = strstr(aHead, ">");
		aClose = strstr(aHead, "</a>");
		hrefHead = strstr(aHead, "href=");
		if (hrefHead && hrefHead < aTail) {
			char quotation[2] = {*(hrefHead + strlen("href=")), 0};
			hrefTail = strstr(hrefHead + strlen("href=") + 1, quotation);
			strncpy(output + outputLen, hrefHead + strlen("href=") + 1, hrefTail - (hrefHead + strlen("href=") + 1));
			outputLen += hrefTail - (hrefHead + strlen("href=") + 1);
			output[outputLen++] = '\n';
			totalHref++;
		}
		cursor = /*aClose + strlen("</a>")*/ aTail + 1;
	}

	output[outputLen] = 0;

	fprintf(hrefFile, "======== Hyperlinks ========\n");
	fprintf(hrefFile, "%s", output);
	fprintf(hrefFile, "============================\n");
	fprintf(hrefFile, "We have found %d hyperlinks\n", totalHref);

	fclose(htmlFileWithoutComment);
	fclose(hrefFile);
}

void outputToTerminal(FILE* log) {

	fprintf(log, "running outputToTerminal()\n");

	FILE* socketFile = fopen("socketFile.txt", "r");
	FILE* hrefFile = fopen("hrefFile.txt", "r");

	char c;

	while (~fscanf(socketFile, "%c", &c)) {
		printf("%c", c);
	}

	while (~fscanf(hrefFile, "%c", &c)) {
		printf("%c", c);
	}

	fclose(socketFile);
	fclose(hrefFile);

}