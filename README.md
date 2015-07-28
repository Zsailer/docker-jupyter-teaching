Docker Images for Temporary Jupyter notebooks
=================================================

This is a simpler fork of Jupyter's repo, [docker-demo-images](https://github.com/jupyter/docker-demo-images), with a docker image that only includes IPython 2/3 kernels. Thus, it provides the base Docker images that the **tmpnb** image can extend to provide temporary Jupyter notebooks.

The primary purpose of this repository is to provide throw-away notebooks for demonstrations in scientific courses without requiring local Python/IPython installs on students' machines.

The docker files are forks of: [`jupyter/demo`](https://registry.hub.docker.com/u/jupyter/demo/) (currently used by [tmpnb.org](https://tmpnb.org)) and [`jupyter/minimal`](https://registry.hub.docker.com/u/jupyter/minimal/).

The rest of the documentation is a direct copy of Jupyter's docker-demo-images documentation.

### Organization

The big demo image pulls in resources from

* `notebooks/` for example notebooks
* `common/` for core components used by `minimal` and `demo`

### Building the Docker Images

There is a Makefile to make life a bit easier here:

```
make images
```

Alternatively, feel free to build them directly:

#### `zsailer/demo`

```
docker build -t zsailer/demo .
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
           jupyter/tmpnb python orchestrate.py --image='jupyter/demo' --command="ipython notebook --NotebookApp.base_url={base_path} --ip=0.0.0.0 --port {port}"
```
