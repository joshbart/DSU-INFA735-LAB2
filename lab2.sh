#!/bin/bash
#
# 

error() {
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: ERROR - $*" >&2
}

main () {
    declare options="-Pn -p- -A"
    declare ipconfig="/opt/infa735lab2/lab2.conf"
    declare tcpreport="/opt/infa735lab2/reports/tcp-$(date +'%Y-%m-%d').nmap"
    declare udpreport="/opt/infa735lab2/reports/udp-$(date +'%Y-%m-%d').nmap"

    nmap "${options}" -sS -iL "${ipconfig}" -oN "${tcpreport}"
    if [[ "$?" -ne 0 ]]; then
        error "Failed to run TCP scan."
        exit 1
    fi

    nmap "${options}" -sU -iL "${ipconfig}" -oN "${udpreport}"
        if [[ "$?" -ne 0 ]]; then
        error "Failed to run UDP scan."
        exit 1
    fi

}

main "$@"
