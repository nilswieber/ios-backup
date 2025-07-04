#! /bin/bash

docker run --rm --name ios-backup \
  -i --privileged -v /dev/:/dev/ --network=host \
  -v $PWD/lockdown:/var/lib/lockdown \
  -v $PWD/backup:/backup \
  --env-file=$PWD/backup.env \
  nilsw/ios-backup /app/backup.sh
