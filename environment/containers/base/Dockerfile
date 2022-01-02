ARG IMAGE_PARENT
FROM $IMAGE_PARENT
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y software-properties-common

