#!/bin/bash

echo "Starting Script Register and Enroll user"  

export PATH=${PWD}/../bin:$PATH
export FABRIC_CFG_PATH=${PWD}/../test-network/configtx
export VERBOSE=false

. ${PWD}/../test-network/scripts/utils.sh

echo "Enter the organization name in lowercase: "  
read org_name

if [ $org_name == "afrinic" ]; then
    infoln "Registering User in Org1"
    export FABRIC_CA_CLIENT_HOME=${PWD}/../test-network/organizations/peerOrganizations/org1.example.com/
    org="org1"
    port="7054"
fi

if [ $org_name == "apnic" ]; then
    infoln "Registering User in Org2"
    export FABRIC_CA_CLIENT_HOME=${PWD}/../test-network/organizations/peerOrganizations/org2.example.com/
    org="org2"
    port="8054"
fi

if [ $org_name == "arin" ]; then
    infoln "Registering User in Org3"
    export FABRIC_CA_CLIENT_HOME=${PWD}/../test-network/organizations/peerOrganizations/org3.example.com/
    org="org3"
    port="11054"
fi

if [ $org_name == "lacnic" ]; then
    infoln "Registerting User in Org4"
    export FABRIC_CA_CLIENT_HOME=${PWD}/../test-network/organizations/peerOrganizations/org4.example.com/
    org="org4"
    port="13054"
fi


if [ $org_name == "ripe" ]; then
    infoln "Registering User in Org5"
    export FABRIC_CA_CLIENT_HOME=${PWD}/../test-network/organizations/peerOrganizations/org5.example.com/
    org="org5"
    port="15054"
fi


echo "Enter username, it should be the asn number: "  
read username


echo "Enter password: "  
read password


infoln "Registering user"
set -x
fabric-ca-client register --caname ca-$org --id.name "asn"$username --id.secret "asn"$password --id.type client --tls.certfiles ${PWD}/../test-network/organizations/fabric-ca/$org/tls-cert.pem
{ set +x; } 2>/dev/null

infoln "Generating the user msp"
set -x
fabric-ca-client enroll -u https://"asn"$username:"asn"$password@localhost:$port --caname ca-$org -M ${PWD}/../test-network/organizations/peerOrganizations/$org.example.com/users/"asn"$username@$org.example.com/msp --tls.certfiles ${PWD}/../test-network/organizations/fabric-ca/$org/tls-cert.pem
{ set +x; } 2>/dev/null

cp ${PWD}/../test-network/organizations/peerOrganizations/$org.example.com/msp/config.yaml ${PWD}/../test-network/organizations/peerOrganizations/$org.example.com/users/"asn"$username@$org.example.com/msp/config.yaml

cp ${PWD}/../test-network/organizations/peerOrganizations/$org.example.com/users/"asn"$username@$org.example.com/msp/signcerts/* ${PWD}/../test-network/organizations/peerOrganizations/$org.example.com/users/"asn"$username@$org.example.com/msp/signcerts/"asn"$username@$org.example.com-cert.pem
cp ${PWD}/../test-network/organizations/peerOrganizations/$org.example.com/users/"asn"$username@$org.example.com/msp/keystore/* ${PWD}/../test-network/organizations/peerOrganizations/$org.example.com/users/"asn"$username@$org.example.com/msp/keystore/priv_sk

infoln "User Registered and Enroll!"




