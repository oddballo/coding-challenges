ARG IMAGE_PARENT
FROM $IMAGE_PARENT
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
	&& add-apt-repository -y ppa:ubuntu-toolchain-r/test \
	&& apt-get update \
	&& apt-get install -y g++-11
