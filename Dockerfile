FROM ubuntu:16.04
MAINTAINER Beau Cronin, beau.cronin@gmail.com

ENV SCRIPDIR .
ENV SCRIPEXEDIR .
ENV SCRIPARCH linuxgfortran_serial

RUN apt-get update
RUN apt-get install -y \
	libnetcdf-dev \
	netcdf-bin \
	libnetcdff-dev \
	libnetcdff6 \
	subversion \
	gfortran \
	csh \
	gawk

RUN svn export http://oceans11.lanl.gov/svn/SCRIP/trunk/SCRIP
ADD linuxgfortran_serial.gnu SCRIP/build
RUN cd SCRIP && \
	./setupTargetDir . && \
	make

# Assumes that /work contains a valid scrip_in file and input grid files,
# via a volume mapping from the docker host
# For example, run via:
# $ docker run -it -v <host_work>:/work <image_id> 
CMD cd /work; /SCRIP/scrip
