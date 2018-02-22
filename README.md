# docker_ftp_tls
Dockerized FTP server that uses TLS v1 and selfsigned cert, used mounted volumes as ftp home.


## Build

docker build -t ftp_ssl:latest . 

## To run

docker run -d -v <HOST_VOLUME>:/home/vsftpd \
                                       	-p 2222:22 -p 20:20 -p 21:21 -p 47400-47470:47400-47470 \
                                        -e FTP_USER=<USER> \
                                        -e FTP_PASS=<PASSWORD> \
                                        -e PASV_ADDRESS=$IPADDRESS \
                                        --name ftp_ssl \
                                        --restart=always ftp_ssl:latest