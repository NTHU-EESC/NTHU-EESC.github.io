#include "lab.h"

void enterServerInfo(char *serverIP, unsigned short *serverPort) {
    printf("═══ Enter Server Info ═══\n");
    printf("Server IP: ");
    scanf("%s", serverIP);
    printf("Server port: ");
    scanf("%hu", serverPort);
    printf("═════════════════════════\n");
}

void sendRequest(char *command, char *filename) {
    Packet packet;
    memset(&packet, 0, sizeof(packet));

    // download<space>filename, without null terminator
    packet.header.size = strlen(command) + 1 + strlen(filename);
    packet.header.isLast = true;
    // Concatenate the command "download" with the filename
    snprintf((char *)packet.data, sizeof(packet.data) - 1, "%s %s", command, filename);

    if (sendto(sockfd, &packet, sizeof(packet), 0, (struct sockaddr *)&serverInfo, sizeof(struct sockaddr_in)) == -1) {
        perror("sendto()");
        exit(EXIT_FAILURE);
    }
}

void recvResponse(char *response) {
    Packet packet;
    memset(&packet, 0, sizeof(packet));

    if (recvfrom(sockfd, &packet, sizeof(packet), 0, (struct sockaddr *)&serverInfo, (socklen_t *)&addrlen) == -1) {
        perror("recvfrom()");
        exit(EXIT_FAILURE);
    }
    // Copy the packet data into the response buffer
    strncpy(response, (char *)packet.data, packet.header.size);
}

void sendAck(unsigned int ack) {
    Packet packet;
    memset(&packet, 0, sizeof(packet));

    packet.header.ack = ack;
    packet.header.isLast = true;

    if (sendto(sockfd, &packet, sizeof(packet), 0, (struct sockaddr *)&serverInfo, sizeof(struct sockaddr_in)) == -1) {
        perror("sendto()");
        exit(EXIT_FAILURE);
    }
}

bool isLoss(double p) {
    // Generate a random number between 0 and 1
    double r = (double)rand() / RAND_MAX;
    return r < p;
}

void recvFile(char *buffer) {
    Packet packet;
    memset(&packet, 0, sizeof(packet));
    // Keep track of the current sequence number
    unsigned int seq = 0;
    memset(buffer, 0, sizeof(buffer));

    time_t start, end;
    start = time(NULL);
    while (true) {
        // ╔═══════════════════════════════════════╗
        // ║ Please remove the two lines below and ║
        // ║ implement the following procedures    ║
        // ╚═══════════════════════════════════════╝
        // printf("Ctrl + C to quit\n");  // <-- Remove this line
        // pause();                       // <-- Remove this line

        // Receive a packet first, then use isLoss()
        // to simulate if it has packet loss
        /*printf("%s\n", buffer);
        pause();*/
        if (recvfrom(sockfd, &packet, sizeof(packet), 0, (struct sockaddr *)&serverInfo, (socklen_t *)&addrlen) == -1) {
            perror("recvfrom()");
            exit(EXIT_FAILURE);
        }

        // Simulate packet loss
        if (isLoss(LOSS_RATE)) {
            printf("Oops! Packet loss!\n");
            continue;
        }

        printf("Received SEQ = %u\n", packet.header.seq);

        // Send an acknowledgement for the received packet
        Packet ack_packet;
        memset(&ack_packet, 0, sizeof(ack_packet));
        ack_packet.header.seq = packet.header.seq;
        ack_packet.header.isLast = packet.header.isLast;
        ack_packet.header.ack = seq;
        if (sendto(sockfd, &ack_packet, sizeof(ack_packet), 0, (struct sockaddr *)&serverInfo, sizeof(struct sockaddr_in)) == -1) {
            perror("sendto()");
            exit(EXIT_FAILURE);
        }

        // Copy the packet data into the buffer
        // Use memcpy() instead of strncpy() since the file
        // may contain 0x00 (interpreted as a null terminator)
        memcpy(buffer + seq * 1024, packet.data, packet.header.size);

        // Increment the sequence number
        seq++;

        // If the packet is the last one, break out of the loop
        if (packet.header.isLast) break;
    }
    
    end = time(NULL);
    printf("Elapsed: %ld sec\n", end - start);
}

void writeFile(char *buffer, unsigned int filesize, char *filename) {
    char newFilename[strlen("download_") + 64];  // filename[64]
    memset(newFilename, '\0', sizeof(newFilename));
    // Concatenate "download_" with the filename
    snprintf(newFilename, sizeof(newFilename) - 1, "download_%s", basename(filename));
    printf("Saving %s\n", newFilename);

    // ╔═══════════════════════════════════════════╗
    // ║ Please implement the following procedures ║
    // ╚═══════════════════════════════════════════╝

    // Create a file descriptor
    FILE* newFile;

    // Name the file as newFilename and open it in write-binary mode
    newFile = fopen(newFilename, "wb");

    // Write the buffer into the file
    // fprintf(newFile, "%b", buffer);
    fwrite(buffer, 1, filesize, newFile);

    // Close the file descriptor
    fclose(newFile);

    // Set the file descriptor to NULL
    newFile = NULL;

    printf("File has been written\n");
}

int main() {
    // Seed the random number generator for packet loss simulation
    srand(time(NULL));
    // xxx.xxx.xxx.xxx + null terminator
    char serverIP[16] = {'\0'};
    unsigned short serverPort;

    enterServerInfo(serverIP, &serverPort);
    setServerInfo(inet_addr(serverIP), serverPort);
    createSocket();

    char command[32];
    char filename[64];
    char response[64];
    size_t filesize;

    while (true) {
        memset(command, '\0', sizeof(command));
        memset(filename, '\0', sizeof(filename));
        memset(response, '\0', sizeof(response));
        filesize = 0;

        printf("Please enter a command:\n");
        if (scanf("%s", command) == EOF)
            break;

        if (strcmp(command, "exit") == 0)
            break;

        if (strcmp(command, "download") == 0) {
            scanf("%s", filename);
            // Send the download request
            sendRequest(command, filename);
            // Receive the response
            recvResponse(response);
            // Determine whether the file exists
            if (strcmp(response, "NOT_FOUND") == 0) {
                printf("File does not exist\n");
                continue;
            }
            // Ignore characters before "=", then read the file size
            sscanf(response, "%*[^=]=%zu", &filesize);
            printf("File size is %zu bytes\n", filesize);
            // Allocate a buffer with the file size
            char *buffer = malloc(filesize);

            printf("═══════ Receiving ═══════\n");
            recvFile(buffer);
            printf("═════════════════════════\n");
            writeFile(buffer, filesize, filename);
            printf("═════════════════════════\n");

            free(buffer);
            buffer = NULL;
            continue;
        }
        printf("Invalid command\n");
        // Clear the input buffer following the invalid command
        while (getchar() != '\n')
            continue;
    }
    close(sockfd);
    return 0;
}
