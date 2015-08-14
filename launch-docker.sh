#!/bin/bash
# launch an cluster of ipython notebooks inside a docker container

USAGE="./launch-docker.sh [num_users = 10]"

num_users=${1}
if [ ! "${num_users}" ]; then
    num_users=10
fi

export TOKEN=$( head -c 30 /dev/urandom | xxd -p )
docker run --net=host -d -e CONFIGPROXY_AUTH_TOKEN=$TOKEN --name=proxy jupyter/configurable-http-proxy --default-target http://127.0.0.1:9999
docker run --net=host -d -e CONFIGPROXY_AUTH_TOKEN=$TOKEN \
           -v /var/run/docker.sock:/docker.sock \
           jupyter/tmpnb python orchestrate.py --pool-size=${num_users} --image='teaching/notebooks' --command="ipython notebook --NotebookApp.base_url={base_path} --ip=0.0.0.0 --port {port}"
