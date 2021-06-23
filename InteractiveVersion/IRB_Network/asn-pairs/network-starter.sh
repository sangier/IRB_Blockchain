#!/bin/bash
#
# SPDX-License-Identifier: Apache-2.0

function _exit(){
    printf "Exiting:%s\n" "$1"
    exit -1
}

# Exit on first error, print all commands.
set -ev
set -o pipefail

# Where am I?
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export FABRIC_CFG_PATH="${DIR}/../config"

cd "${DIR}/../test-network/"

docker kill cliDigiBank cliMagnetoCorp logspout || true
./network.sh down
./network.sh up createChannel -ca -s couchdb

# Copy the connection profiles so they are in the correct organizations.
cp "${DIR}/../test-network/organizations/peerOrganizations/org1.example.com/connection-org1.yaml" "${DIR}/organization/org1/gateway/"
cp "${DIR}/../test-network/organizations/peerOrganizations/org2.example.com/connection-org2.yaml" "${DIR}/organization/org2/gateway/"
cp "${DIR}/../test-network/organizations/peerOrganizations/org3.example.com/connection-org3.yaml" "${DIR}/organization/org3/gateway/"
cp "${DIR}/../test-network/organizations/peerOrganizations/org4.example.com/connection-org4.yaml" "${DIR}/organization/org4/gateway/"
cp "${DIR}/../test-network/organizations/peerOrganizations/org5.example.com/connection-org5.yaml" "${DIR}/organization/org5/gateway/"
cp "${DIR}/../test-network/organizations/peerOrganizations/org6.example.com/connection-org6.yaml" "${DIR}/organization/org6/gateway/"


echo Suggest that you monitor the docker containers by running
echo "./organization/magnetocorp/configuration/cli/monitordocker.sh net_test"
