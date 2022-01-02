ARG IMAGE_PARENT
FROM $IMAGE_PARENT
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
	&& apt-get install openjdk-17-jdk openjdk-17-jre maven -y
