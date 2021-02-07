# A wrapper around the SSH client provided on the BASH shell

In this repository, the file `sshx.sh` is meant to be a command line SSH client tool that can get you results from your remote device in a quick and automated manner. By no means is this perfect (yet), but it a clean, fun way to interact with network devices to get instant results from the CLI.

The file `sshx.sh` is a bash shell script which should reside in your file system in an executable mode. Be sure to `chmod +x` the file!

# How to use

Say you cloned this repository on your system at `/home/sshx`. After giving the file an executable mode via `chmod`, visit your user's `bashrc` file to include the following alias at the end:

```
alias sshx=/home/sshx/./sshx.sh
```

Then, edit the `sshx.sh` file to include your SSH password to login to your device(s) and give the port at which the device is reachable at via SSH (I have left the default as 22). Save the file. Restart your shell, `exec $SHELL` should do it for you.

Now you should be able run a command such as `sshx user 10.129.88.92 "sh ip int brief"`, where `user` is the SSH username connecting to the host `10.129.88.92` and get back the output for `sh ip int brief`:

```
COMPUTER~$ sshx user 10.129.88.92 "sh ip int brief"
CONNECTING TO 10.129.88.92 AS user
spawn ssh -o StrictHostKeyChecking=no -o ConnectTimeout=30 user@10.129.88.92 -p 8181
Password:


RP/0/RP0/CPU0:iosxr1#sh ip int brief
Sun Feb  7 23:59:57.071 UTC

Interface                      IP-Address      Status          Protocol Vrf-Name
Loopback100                    1.1.1.100       Up              Up       default
Loopback200                    1.1.1.200       Up              Up       default
MgmtEth0/RP0/CPU0/0            10.10.20.175    Up              Up       default
GigabitEthernet0/0/0/0         unassigned      Shutdown        Down     default
GigabitEthernet0/0/0/1         unassigned      Shutdown        Down     default
GigabitEthernet0/0/0/2         unassigned      Shutdown        Down     default
GigabitEthernet0/0/0/3         unassigned      Shutdown        Down     default
GigabitEthernet0/0/0/4         unassigned      Shutdown        Down     default
GigabitEthernet0/0/0/5         unassigned      Shutdown        Down     default
GigabitEthernet0/0/0/6         unassigned      Shutdown        Down     default
RP/0/RP0/CPU0:iosxr1#Disconnected
COMPUTER~$
```

Without interacting with the device at all.