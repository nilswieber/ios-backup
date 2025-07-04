#! /bin/bash
service dbus start
service avahi-daemon start

usbmuxd -c $DEVICE_IP --pair-record-id $RECORD_ID &  

BACKUP_EXITCODE=1
tryBackup(){
  echo "Initiating Backup"
  idevicebackup2 -n backup --full /backup
  BACKUP_EXITCODE=$?
}

TIMEOUT=1
TRYS=1
MAX_TRYS=15
while [ $BACKUP_EXITCODE -ne 0 ] && [ $TRYS -le $MAX_TRYS ]; do
  tryBackup
  if [ $BACKUP_EXITCODE -eq 48 ]; then
    echo "Backup canceled by user. Exiting"
    exit 0
  fi  
  if [ $BACKUP_EXITCODE -ne 0 ]; then
    echo "Backup failed with exit code $BACKUP_EXITCODE"
    echo "Trying again in $TIMEOUT seconds"
     
    sleep $TIMEOUT
    TIMEOUT=$(( $TIMEOUT * 2))
  fi
  TRYS=$(( $TRYS + 1 )) 
done 

