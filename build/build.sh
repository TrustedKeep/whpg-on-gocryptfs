#!/usr/bin/env bash

SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
cd "${SCRIPT_DIR}" || exit 0

WHPG_VERSION="${WHPG_VERSION:-7.3.1-WHPG}"
image="whpg_${WHPG_VERSION,,}"

docker build -t "${image}" .

docker run --rm -it -v "${PWD}:/work" -w /work "${image}" \
	bash -c "tar zcf whpg.tar.gz -C /usr/local whpg && chown $(id -u):$(id -g) whpg.tar.gz"
