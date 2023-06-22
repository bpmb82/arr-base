FROM debian:bookworm-slim

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"

RUN \
 echo "**** install apt-transport-https first ****" && \
 apt-get update && \
 apt-get upgrade -y && \
 apt-get install -y apt-transport-https gnupg2 curl && \
 echo "**** add mediaarea repository ****" && \
 curl -L \
	"https://mediaarea.net/repo/deb/repo-mediaarea_1.0-21_all.deb" \
	-o /tmp/key.deb && \
 dpkg -i /tmp/key.deb && \
 echo "deb https://mediaarea.net/repo/deb/debian bullseye main" | tee /etc/apt/sources.list.d/mediaarea.list && \
 echo "**** install packages ****" && \
 apt-get update && apt-get install -y \
 	--no-install-recommends \
	--no-install-suggests \
	bzip2 \
	libcurl4-openssl-dev \
	mediainfo \
	sqlite3 \
	unzip && \
 echo "**** clean up ****" && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*