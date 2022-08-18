#!/bin/sh

targz="${1}"
if [ -z "${targz}" ]; then
	echo "Compressed image tarball is required" && exit 1
fi
basedir=$(dirname "${targz}")
imagename=$(basename "${targz%*.tar.gz}")

DOCKERD=$(command -v dockerd)
DOCKER=$(command -v docker)
# Launch docker
"$DOCKERD" > /dev/null 2>&1 &
while(! "${DOCKER}" info > /dev/null 2>&1); do
	sleep 1
done

echo "Creating a container image from ${targz}"
cid=$("$DOCKER" import "${targz}")
if [ -z "${cid}" ]; then
	echo "Image ${image} import failed" && exit 1
fi
"$DOCKER" save "${cid}" > "${basedir}/${imagename}.docker" 
if [ -f "${basedir}/${imagename}.docker" ]; then
	echo "::set-output name=image::${basedir}/${imagename}.docker"
else
	echo "Contanerization of ${image} failed" && exit 1
fi
