all: client server

client: lab.h client.c
	gcc client.c -o client

server: lab.h server.c
	gcc server.c -o server

clean:
	rm -f client server
