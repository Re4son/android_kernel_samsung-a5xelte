#!/system/bin/sh

on property:sys.boot_completed=1
    start prashantp

service prashantp /sbin/prashantp.sh
    class late_start
    user root
    seclabel u:r:init:s0
    oneshot
    disabled