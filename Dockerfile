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
	gfortran

RUN svn export http://oceans11.lanl.gov/svn/SCRIP/trunk/SCRIP
ADD linxgfortran_serial.gnu SCRIP/build
RUN ./setupTargetDir . && make
