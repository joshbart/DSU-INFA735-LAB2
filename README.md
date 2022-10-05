# DSU-INFA735-LAB2

According to multiple issues of the [Verizon Data Breach Investigations Report](https://www.verizon.com/business/resources/reports/dbir/), misconfiguration of IT assets is one of the leading causes of data breaches year after year. Specifically, firewall misconfigurations can have a devastating impact on operations. Malicious actors who find accidentally open ports can attempt to exploit weak software listening inside of a victim's network. This project aims to aid in the detection—and subsequent removal—of network perimeter misconfigurations. It is designed to provide recurring observations of a network perimeter from an external location, just as a threat actor might also do. It maintains reports to allow review historical observations and runs in a containerized manner, providing a high degree of flexibility and scalability.

## Architecture

This project utilizes the following products or services:
- Docker
- cron
- nmap

The Docker container runs a foreground cron process. The cron process references a `lab2cron` file located in `/etc/cron.d`, which executes the `lab2.sh` bash script on a daily basis. The script provides appropriate options and parameters to `nmap`, which does the heavy lifting of scanning a network perimeter. Upon completion of a scan, `nmap` places a report in `/opt/lab2/reports`. This folder is also persisted on the Docker host file system.  Ideally, this host would be located outside of the perimeter network needing to be scanned; it should be able to be run on a laptop or in a cloud service with very little overhead.

## Installation

1. Clone this repository to a system capable of building Docker images - `$ git clone https://github.com/joshbart/DSU-INFA735-LAB2.git`
2. Update `lab2.conf` with the IP addresses you would like to monitor; each IP address should be on a new line
3. Review the options in `lab2.sh` to ensure that scanning is being conducted as desired
4. Review the `lab2cron` to ensure that the schedule is appropriate for the organization being scanned
5. Build the container using the following command: `# docker build --rm -t lab2:<date> .`
6. Run the container using the following command: `# docker run -it --rm -v <local reports folder>:/opt/lab2/reports lab2:<date>`

## Roadmap

Future features that would improve the usefulness of this tool include:
- Sending completed reports to a list of emails
- A web-based frontend for dynamic configuration changes that would allow for more of an "as-a-Service" feel
- On-the-fly scanning of IP:port combinations to provide faster results
