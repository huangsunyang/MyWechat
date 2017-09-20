#include "utility.h"
#include <algorithm>
#include <thread>

void my_shell() {
    while(true) {
        std::string command;
        std::cin >> command;
        std::transform(command.begin(), command.end(), command.begin(), ::tolower);
        if (command == "quit" || command == "exit") {
            exit(-1);
        } else if (command == "ls") {
            
        }
    }
}

struct Client {
    Client(): socket_fd(-1), is_alive(false){}
    Client(int fd, bool lv): socket_fd(fd), is_alive(lv){}
    int socket_fd;
    bool is_alive;
};

std::map<std::string, Client> all_connected_users;

int main() {
    std::thread my_thread(my_shell);
    
    struct sockaddr_in serverAddr;
    serverAddr.sin_family = PF_INET;
    serverAddr.sin_port = htons(SERVER_PORT);
    serverAddr.sin_addr.s_addr = inet_addr(SERVER_IP);
    
    int listener = socket(PF_INET, SOCK_STREAM, 0);
    if (listener < 0) {
        perror("Listener");
        exit(-1);
    }
    
    std::cout << "Listen socket created" << std::endl;
    
    if (bind(listener, (struct sockaddr *)&serverAddr, sizeof(serverAddr)) < 0) {
        perror("bind error");
        exit(-1);
    }
    
    int ret = listen(listener, 5);
    if (ret < 0) {
        perror("listen error");
        exit(-1);
    }
    
    std::cout << "Start to listen" << std::endl;

    int kqfd = kqueue();
    
    if (kqfd < 0) {
        perror("kqfd error");
        exit(-1);
    }
    
    std::cout << "epoll created. epollfd = " << kqfd << std::endl;
    static struct kevent events[EPOLL_SIZE];

    addfd(kqfd, listener, true);

    while (true) {
        int epoll_events_count = kevent(kqfd, NULL, 0, events, EPOLL_SIZE, NULL);
        if (epoll_events_count < 0) {
            perror("epoll failure");
            break;
        }

        std::cout <<"epoll_enents_count = " << epoll_events_count << std::endl;
        for (int i = 0; i < epoll_events_count; i++) {
            int sockfd = (int)events[i].ident;

            if (sockfd == listener) {
                struct sockaddr_in client_address;
                socklen_t client_addrLength = sizeof(struct sockaddr_in);
                int clientfd = accept(listener, (struct sockaddr*) &client_address, &client_addrLength);
                

                std::cout << "client connection from " << inet_ntoa(client_address.sin_addr) << ":"
                    << ntohs(client_address.sin_port) << "(IP:PORT), clientfd = " << clientfd << std::endl;

                addfd(kqfd, clientfd, true);

                clients_list.push_back(clientfd);

                std::cout << "add new clientfd = " << clientfd << " to epoll" << std::endl;
                std::cout << "Now there are " << clients_list.size() << " clients connected to the server" << std::endl;

                char message[BUF_SIZE];
                bzero(message, BUF_SIZE);
                sprintf(message, SERVER_WELCOME, clientfd);

                int ret = (int)sendProtobufData(clientfd, message, BUF_SIZE, 0);
                std::cout << "send feedback = " << ret << std::endl;
                if (ret < 0) {
                    perror("send error");
                    exit (-1);
                }
            } else {
                std::cout << "receive message " << std::endl;
                int ret = sendBroadcastmessage(sockfd);
                if (ret < 0) {
                    perror("send error");
                    exit (-1);
                }
            }
        }
    }
    close(listener);
    close(kqfd);
    return 0;
}
                
