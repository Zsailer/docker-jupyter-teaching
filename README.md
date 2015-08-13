Docker Images for Temporary Jupyter notebooks
=================================================

This is a simpler fork of Jupyter's repo, [docker-demo-images](https://github.com/jupyter/docker-demo-images), with a docker image that only includes IPython 2/3 kernels. Thus, it provides the base Docker images that the **tmpnb** image can extend to provide temporary Jupyter notebooks.

The primary purpose of this repository is to provide throw-away notebooks for demonstrations in scientific courses without requiring local Python/IPython installs on students' machines.

The docker files are forks of: [`jupyter/demo`](https://registry.hub.docker.com/u/jupyter/demo/) (currently used by [tmpnb.org](https://tmpnb.org)) and [`jupyter/minimal`](https://registry.hub.docker.com/u/jupyter/minimal/).

###Setting up your environment
Docker must be installed and the docker daemon running prior to building or hosting docker images.  On ubuntu:

```
sudo apt-get install docker docker.io
sudo /etc/init.d/docker start
```

Docker must be built and run using `sudo` by default.  To avoid this, add yourself to the `docker` group.  

```
sudo usermod -a -G docker USERNAME
```

You'll have to log in and log back out for this new group assignment to take effect.  

###Quickstart

####Build docker containers and start up.
```
make images #takes a loooooonnng time
docker build -t teaching/exercises teaching/ # build the image with all ipython notebooks
./launch-docker.sh # will take a loooonng time on the first run.  quick thereafter.
```

####Update ipython notebooks
If you want to update or add new ipython notebooks, place them in the teaching/notebooks directory and then run:

```
nuke-docker.sh # stop/remove any existing docker containers
build -t teaching/exercises teaching/
./launch-docker.sh
```

### Organization

The core image pulls in resources from

* `common/` for core components used by `minimal` and `core`

### Building the Docker Images

There is a Makefile to make life a bit easier here:

```
make images
```

Alternatively, feel free to build them directly:

#### `teaching/core`

```
docker build -t teaching/core .
```

#### `jupyter/minimal`

```
docker build -t jupyter/minimal common/
```

### Launching tmpnb

To launch these notebooks using tmpnb, type the following after building the Docker images:

```
export TOKEN=$( head -c 30 /dev/urandom | xxd -p )
docker run --net=host -d -e CONFIGPROXY_AUTH_TOKEN=$TOKEN --name=proxy jupyter/configurable-http-proxy --default-target http://127.0.0.1:9999
docker run --net=host -d -e CONFIGPROXY_AUTH_TOKEN=$TOKEN \
           -v /var/run/docker.sock:/docker.sock \
           jupyter/tmpnb python orchestrate.py --image='teaching/exercises' --command="ipython notebook --NotebookApp.base_url={base_path} --ip=0.0.0.0 --port {port}"
```

This monster command can be run using `launch-docker.sh` in the base directory.
