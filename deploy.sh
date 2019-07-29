#!/usr/bin/env bash

set -e
#set -x

SERVICE=$1

if [[ -z "$SERVICE" ]]
then
  >&2 echo "Must provide service"
  exit 1
fi

APP="${SERVICE}-0.0.1"
USER=apps1
SERV=31.172.137.40
PORT=60022

mydir=$(cd $(dirname $0); pwd)

cd "$mydir/$SERVICE"

echo
echo "DEPLOY..."
echo

scp -o StrictHostKeyChecking=no "$APP.conf" "target/$APP.jar" -P $PORT $USER@$SERV:~/

echo
echo "RESTART..."
echo

ssh -o StrictHostKeyChecking=no -p $PORT $USER@$SERV "
if [ ! -f /etc/init.d/$APP ]
then
    sudo ln -s /home/$USER/$APP.jar /etc/init.d/$APP
    sudo update-rc.d $APP defaults 99
fi
sudo /etc/init.d/$APP restart
sleep 10
tail -n 100 /var/log/$APP.log
"