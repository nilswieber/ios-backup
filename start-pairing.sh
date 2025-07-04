#! /bin/bash

docker run --rm --name ios-backup \
  -i --privileged -v /dev/:/dev/ --network=host \
  -v $PWD/lockdown:/var/lib/lockdown \
  --env-file=$PWD/backup.env \
  nilsw/ios-backup pair.sh
