#!/bin/bash

# nuke all running docker instances

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
