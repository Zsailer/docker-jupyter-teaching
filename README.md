Docker Images for Jupyter notebooks through tmpnb.
=================================================

This is a simpler fork of Jupyter's repo, [docker-demo-images](https://github.com/jupyter/docker-demo-images), with a docker image that only includes IPython 2/3 kernels. Thus, it provides the boilerplate code for hosting temporary Jupyter notebooks on a server using Docker containers.

The primary purpose of this repository is to provide throw-away notebooks for demonstrations in scientific courses without requiring local Python/IPython installs on students' machines.

The docker files are forks of: [`jupyter/demo`](https://registry.hub.docker.com/u/jupyter/demo/) (currently used by [tmpnb.org](https://tmpnb.org)) and [`jupyter/minimal`](https://registry.hub.docker.com/u/jupyter/minimal/).

The rest of the documentation is a direct copy of Jupyters docker-demo-images documentation.

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

#### `jupyter/demo`

```
docker build -t jupyter/demo .
```

#### `jupyter/minimal`

```
docker build -t jupyter/minimal common/
```
