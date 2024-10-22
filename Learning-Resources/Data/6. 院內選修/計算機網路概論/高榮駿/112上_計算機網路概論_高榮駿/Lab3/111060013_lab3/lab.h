#include <arpa/inet.h>
#include <libgen.h>
#include <poll.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <time.h>
#include <unistd.h>
// #include <pthread.h>
// pthread is needed if you want to implement the bonus part
// also, you need change the Makefile to link pthread library
// gcc server.c -o server -pthread

#define TIMEOUT 100
#define LOSS_RATE 0.3

/**
 * Packet header format
 */
typedef struct header {
    unsigned int seq;
    unsigned int ack;
    unsigned int size;  // Payload size
    bool isLast;
    // Note that C does not have a built-in boolean data type,
    // the stdbool.h header is part of the C99 standard and
    // provides the data type bool, constants true and false
} Header;

/**
 * Packet structure
 */
typedef struct packet {
    Header header;
    unsigned char data[1024];
    // Use unsigned char to represent byte
    // Payload size is fixed at 1024 bytes
} Packet;

/**
 * Global variables
 * This is for the sake of simplicity,
 * but keep in mind that this is not a good practice
 */
int sockfd;
struct sockaddr_in serverInfo, clientInfo;
socklen_t addrlen;

/**
 * Static inline functions
 */
static inline void setServerInfo(in_addr_t address, unsigned short port) {
    memset(&serverInfo, 0, sizeof(serverInfo));
    serverInfo.sin_family = AF_INET;
    serverInfo.sin_addr.s_addr = address;
    serverInfo.sin_port = htons(port);
    addrlen = sizeof(struct sockaddr_in);
}

static inline void setClientInfo() {
    memset(&clientInfo, 0, sizeof(clientInfo));
    clientInfo.sin_family = AF_INET;
}

static inline void createSocket() {
    if ((sockfd = socket(AF_INET, SOCK_DGRAM, 0)) == -1) {
        perror("socket()");
        exit(EXIT_FAILURE);
    }
}

static inline void bindSocket() {
    if (bind(sockfd, (struct sockaddr *)&serverInfo, sizeof(struct sockaddr_in)) == -1) {
        perror("bind()");
        exit(EXIT_FAILURE);
    }
}
