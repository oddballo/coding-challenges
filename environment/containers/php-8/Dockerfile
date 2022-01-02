ARG IMAGE_PARENT
FROM $IMAGE_PARENT
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
	&& apt-get install -y software-properties-common \
	&& add-apt-repository ppa:ondrej/php \
	&& apt-get update \
	&& apt-get install -y php8.0-cli
