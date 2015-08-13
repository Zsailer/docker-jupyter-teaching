images: minimal-image core-image

minimal-image:
	docker build -t jupyter/minimal common/

core-image: minimal-image
	docker build -t teaching/core .

notebook-image: core-image
	docker build -t teaching/notebooks teaching/

super-nuke: nuke
	-docker rmi jupyter/minimal
	-docker rmi teaching/core
	-docker rmi teaching/notebooks

# Cleanup with fangs
nuke:
	-docker stop `docker ps -aq`
	-docker rm -fv `docker ps -aq`
	-docker images -q --filter "dangling=true" | xargs docker rmi

.PHONY: nuke
