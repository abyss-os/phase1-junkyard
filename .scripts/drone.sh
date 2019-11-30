#!/bin/sh
[ -z "${DRONE_BUILD_EVENT}" ] && exit 1

echo "trigger: ${DRONE_BUILD_EVENT}"
echo "previous: ${DRONE_COMMIT_BEFORE}"
echo "current: ${DRONE_COMMIT_SHA}"

[ ! -z "${MC_HOST_master}" ] && echo "minio, activate!"

OPWD=${PWD}

for PKG in $(git log ...${DRONE_COMMIT_BEFORE} --format=format: --name-only | grep -e 'APKBUILD$' | tac); do
	echo "${PKG}:"
	cd ${OPWD}/${PKG%APKBUILD} && abuild -ri
done
