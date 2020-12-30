#!/bin/bash

DOCKERFILE="Dockerfile" 
PUSH=0
BUILD=0

while getopts f:a:i:r: option; do
    case "${option}" in
      f) DOCKERFILE=${OPTARG};;
      a) ARCHITECTURE=${OPTARG};; 
      i) IMG=${OPTARG};;
      r) REPOSITORY=${OPTARG};;
    esac
done

while [[ $# -gt 0 ]]; do
    args="$1"
    case $args in
        -h|--help)
        echo "Script arguments:"
        echo "-f:  The name of the Dockerfile to be used"
        echo "-i: The name of the resulting image"     
        echo "-r: The URL of the container registry you want to push to"
        echo "-h, --help: Show these options again"
        exit 1
        ;;
    esac
    shift
done

# Error handling.
if [ -z "$IMG" ]; then
  echo "You must set the image name! Call this script using '-i <IMAGE_NAME>'. Call this script with '--help' for more info"
  exit 1
else
  echo "Building image: ${IMG}"
  echo "Using Dockerfile: ${DOCKERFILE}"
  if [ ${PUSH} -eq 1 ]; then
    if [ -z "$REPOSITORY" ]; then
      echo "You must set the registry address with '-reg <REGISTRY_PATH>' if you want to push these images!"
      exit 1
    else
      echo "Associated with repo: ${REPOSITORY}"
    fi
  fi 
fi

# Architecture mapping.
if [ -z "${ARCHITECTURE}" ]
then
  ARCHITECTURE=( 'amd64' 'arm64v8' 'arm32v7' ) 
  echo "archs to be built are: ${ARCHITECTURE}"
fi

qemu_archs=(  'arm'  'x86_64' 'aarch64')
my_qemu_arch="$(uname -m)"
for i in ${!qemu_archs[@]}; do
  if [ "${qemu_archs[$i]}" = "${my_qemu_arch}" ]; then
      my_docker_arch="${ARCHITECTURE[$i]}"
   fi
done

echo "Building ${REPOSITORY}/${IMG} with qemu ${qemu_archs} for ${ARCHITECTURE}"

# Applying architecture build.
for i in ${!ARCHITECTURE[@]}; do
  docker_arch=${ARCHITECTURE[$i]}
  if [ $docker_arch == 'amd64' ]; then
    qemu_arch="x86_64"
  elif [ $docker_arch == 'arm64v8' ]; then
    qemu_arch="aarch64"
  elif [ $docker_arch == 'arm32v7' ]; then
    qemu_arch="arm"
  else
    echo "couldn't find an appropriate qemu arch for ${docker_arch}!"
  fi

  echo "building with qemu: ${qemu_arch}!"

  new_dockerfile="dockerfile_${IMG}:${docker_arch}"
  cp ${DOCKERFILE}.cross ${new_dockerfile}
  sed -i "s/__BASEIMAGE_ARCH__/${docker_arch}/g" ${new_dockerfile}
  sed -i "s/__QEMU_ARCH__/${qemu_arch}/g" ${new_dockerfile} # select qemu file to copy in the image

  # for the image of my arch, do not copy qemu file (remove COPY line)
  if [ "${docker_arch}" = "${my_docker_arch}" ]; then
    sed -i "/__CROSS_/d" ${new_dockerfile}
  elif test -f "qemu-${qemu_arch}-static"; then
    echo "using qemu-${qemu_arch}-static"
    sed -i "s/__CROSS_//g" ${new_dockerfile}
  elif  test -f "/usr/bin/qemu-${qemu_arch}-static"; then
    cp /usr/bin/qemu-${qemu_arch}-static .
    sed -i "s/__CROSS_//g" ${new_dockerfile}
  else
    echo "no qemu file found for ${qemu_arch}!"
  fi
done