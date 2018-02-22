FROM ubuntu:latest

MAINTAINER malkazwini@gmail.com 

RUN apt-get update && \
                apt-get install -y --no-install-recommends openssl vsftpd db-util && \
                apt-get clean

#Configure SSL with vsftpd
RUN openssl req -x509 -nodes -days 3650 -newkey rsa:1024 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem -subj '/CN=example.com/O=MyCompany/C=CA'

ENV FTP_USER admin
ENV FTP_PASS admin
ENV PASV_ADDRESS REQUIRED

COPY vsftpd.conf /etc/vsftpd/
COPY vsftpd_virtual /etc/pam.d/
COPY run-vsftpd.sh /usr/sbin/

RUN chmod +x /usr/sbin/run-vsftpd.sh && \
                mkdir -p /var/run/vsftpd/empty

VOLUME /home/vsftpd
VOLUME /var/log/vsftpd

EXPOSE 20 21 22

CMD ["/usr/sbin/run-vsftpd.sh"]
