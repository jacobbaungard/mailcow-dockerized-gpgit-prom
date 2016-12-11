#!/bin/bash

. mailcow.conf

NAME="pdns-mailcow"

echo "Stopping and removing containers with name tag ${NAME}..."
if [[ ! -z $(docker ps -af "name=${NAME}" -q) ]]; then
	docker stop $(docker ps -af "name=${NAME}" -q)
	docker rm $(docker ps -af "name=${NAME}" -q)
fi

build() {
	docker build --no-cache -t pdns data/Dockerfiles/pdns/.
}

if [[ ! -z "$(docker images -q pdns)" ]]; then
    read -r -p "Found image locally. Delete local and rebuild without cache anyway? [y/N] " response
	response=${response,,}
	if [[ $response =~ ^(yes|y)$ ]]; then
		docker rmi pdns
		build
	fi
else
	build
fi

sed -i "s#allow-from.*#allow-from=127.0.0.0/8 ${DOCKER_SUBNET}#" data/conf/pdns/recursor.conf

docker run \
	-v ${PWD}/data/conf/pdns/:/etc/powerdns/ \
	--network=${DOCKER_NETWORK} \
	--network-alias pdns \
	-h pdns \
	--name ${NAME} \
	-d pdns
