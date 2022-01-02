# Docker client on Windows (using remote instance)

To use a remote instance to provide the Docker API, you need to;

- Install the Docker Command Line tool (available here https://github.com/docker/cli)
- Expose the Docker socket over the network on the remote instance (dockerhost-ubuntu20.04 has an example)
- Configure DOCKER\_HOST to address the remote instance (setup.bat has an example)
