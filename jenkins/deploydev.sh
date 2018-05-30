#!/usr/bin/env bash

set -x

mvn jar:jar install:install
NAME=`mvn help:evaluate -Dexpression=project.name | grep "^[^\[]"`
VERSION=`mvn help:evaluate -Dexpression=project.version | grep "^[^\[]"`
java -jar target/${NAME}-${VERSION}.jar
