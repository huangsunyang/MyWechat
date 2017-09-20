#include <iostream>
#include <list>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#include <fcntl.h>
#include <errno.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/event.h>
#include <sys/time.h>
#include <string>
#include "MWNetworkData.pb.h"

#define SERVER_IP "127.0.0.1"
#define SERVER_PORT 4866
#define EPOLL_SIZE 5000
#define SERVER_MESSAGE "%s"
#define EXIT "EXIT"
#define CAUTION "There is only one int the char room!"
#define BUF_SIZE 0xFFFF
#define SERVER_WELCOME "Welcome you join  to the chat room! Your chat ID is: Client #%d"

std::list<int> clients_list;

int setnonblocking(int sockfd) {
    fcntl(sockfd, F_SETFL, fcntl(sockfd, F_GETFD, 0) | O_NONBLOCK);
    return 0;
}


void addfd(int kqfd, int fd, bool enable_et) {
    struct kevent ev;
    EV_SET(&ev, fd, EVFILT_READ|EVFILT_WRITE, EV_ADD|EV_ENABLE, 0, 0, (void*)(intptr_t)fd);
    
    kevent(kqfd, &ev, 1, NULL, 0, NULL);
    //setnonblocking(fd);
    std::cout << "fd added to epoll!\n\n" << std::endl;
}

ssize_t sendProtobufData(int socket_fd, char * message, int size, int flag) {
    MWNetworkData data;
    data.set_str_data(message);
    data.set_from_usr("huangsunyang");
    data.set_to_usr("chougei");
    std::string str;
    data.SerializeToString(&str);
    puts("--------------------------");
    printf("%s\n", (char *)str.c_str());
    puts("--------------------------");
    return send(socket_fd, str.c_str(), str.size(), flag);
}

int sendBroadcastmessage(int clientfd) {
    char buf[BUF_SIZE], message[BUF_SIZE];
    bzero(buf, BUF_SIZE);
    bzero(message, BUF_SIZE);

    std::cout << "read from client(client ID = " << clientfd << std::endl;
    ssize_t len = recv(clientfd, buf, BUF_SIZE, 0);

    puts("------------------------");
    printf("%s\n", (char *)buf);
    puts("------------------------");
    std::string str = std::string(buf, len);
    MWNetworkData data;
    data.ParseFromString(str);
    std::cout << data.str_data() << std::endl;
    
    if (len == 0) {
        close(clientfd);
        clients_list.remove(clientfd);
        std::cout << "ClientID = " << clientfd << "closed. ";
        std::cout << "There are " << clients_list.size() << " client connected to the Server" << std::endl;
    } else {
        sprintf(message, SERVER_MESSAGE, data.str_data().c_str());

        for (auto it = clients_list.begin(); it != clients_list.end(); it++) {
            int ret;
            if ((ret = (int)sendProtobufData(*it, message, BUF_SIZE, 0) < 0)) {
                perror("error");
                exit(-1);
            } else {
                std::cout << "send feedback: " << ret << std::endl;
            }
        }
    }
    return int(len);
}
