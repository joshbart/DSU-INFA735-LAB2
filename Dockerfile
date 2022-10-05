FROM ubuntu:latest

# Install software
RUN apt-get update && apt-get install nmap cron -y

# Copy files
COPY lab2.sh /opt/lab2/
RUN chmod 0744 /opt/lab2/lab2.sh
COPY lab2.conf /opt/lab2/
RUN mkdir /opt/lab2/reports

COPY lab2cron /etc/cron.d/lab2cron
RUN chmod 0644 /etc/cron.d/lab2cron && touch /var/log/cron.log

# CMD ["cron", "-f"]
ENTRYPOINT [ "/bin/bash" ]