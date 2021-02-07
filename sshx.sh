#!/bin/bash

USER=$1
HOST=$2
PASSWORD="" # enter password
PORT="22"
COMMAND=$3

/usr/bin/expect <<- EOD
        set timeout 30
        log_user 1
        set send_slow {1 .01}

        send_user "CONNECTING TO $HOST AS $USER\n"
        spawn ssh -o StrictHostKeyChecking=no -o ConnectTimeout=30 "$USER\@$HOST" -p "$PORT"
        expect {
	        timeout { send_user "timeout while connecting to $HOST as $USER\n"; exit }
                "*No route*" { send_user "$HOST is unreachable, sorry!\n"; exit }
                "*assword: " { send -s "$PASSWORD\r" }
        }
        expect {
	        timeout { send_user "timeout waiting for device prompt\n"; exit }
		"*#" { send -- "$COMMAND\r" } 
	}
	expect {
		"*#" { send "exit\r" }
	}
	send_user "Disconnected\n"
	close
EOD
