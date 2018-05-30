#!/usr/bin/env bash

set -x

mvn jar:jar install:install
NAME=`mvn help:evaluate -Dexpression=project.name | grep "^[^\[]"`
VERSION=`mvn help:evaluate -Dexpression=project.version | grep "^[^\[]"`
scp target/${NAME}-${VERSION}.jar root@47.93.134.246:/usr/local/jars
ssh root@47.93.134.246 "cd /usr/local/jars; source /etc/profile; java -jar ${NAME}-${VERSION}.jar"
