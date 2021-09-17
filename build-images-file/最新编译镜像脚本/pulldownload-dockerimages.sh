#!/bin/bash -eu
#
# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0
#


##################################################
# This script pulls docker images from hyperledger
# docker hub repository and Tag it as
# hyperledger/fabric-<image> latest tag
##################################################

dockerBasePull() {
  local BASE_TAG=$1
  for IMAGES in  testenv javaenv; do
      echo "==> FABRIC IMAGE: $IMAGES"
      echo
      docker pull hyperledger/fabric-$IMAGES:$BASE_TAG
      docker tag hyperledger/fabric-$IMAGES:$BASE_TAG hyperledger/fabric-$IMAGES
  done
}


#dockerCaPull() {
#      local CA_TAG=$1
#      echo "==> FABRIC CA IMAGE"
#     echo
#      docker pull hyperledger/fabric-ca:$CA_TAG
#      docker tag hyperledger/fabric-ca:$CA_TAG hyperledger/fabric-ca
#}
usage() {
      echo "Description "
      echo
      echo "Pulls docker images from hyperledger dockerhub repository"
      echo "tag as hyperledger/fabric-<image>:latest"
      echo
      echo "USAGE: "
      echo
      echo "./download-dockerimages.sh [-c <fabric-ca tag>] [-f <fabric tag>]"
      echo "      -c fabric-ca docker image tag"
      echo "      -f fabric docker image tag"
      echo
      echo
      echo "EXAMPLE:"
      echo "./download-dockerimages.sh -c 1.1.1 -f 1.1.0"
      echo
      echo "By default, pulls the 'latest' fabric-ca and fabric docker images"
      echo "from hyperledger dockerhub"
      exit 0
}

while getopts "\?hc:" opt; do
  case "$opt" in
    
     \?|h) usage
        echo "Print Usage"
        ;;
  esac
done

#: ${CA_TAG:="latest"}
: ${BASE_TAG:="amd64-0.4.15"}

echo "===> Pulling fabric Images"
dockerBasePull ${BASE_TAG}

#echo "===> Pulling fabric ca Image"
#dockerCaPull ${CA_TAG}
echo
echo "===> List out hyperledger docker images"
docker images | grep hyperledger*
