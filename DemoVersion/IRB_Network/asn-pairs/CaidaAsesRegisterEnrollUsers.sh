#!/bin/bash

echo "Starting Script"  

export PATH=${PWD}/../bin:$PATH
export FABRIC_CFG_PATH=${PWD}/../test-network/configtx
export VERBOSE=false

. ${PWD}/../test-network/scripts/utils.sh

  infoln "Enrolling Users in Org1"

  export FABRIC_CA_CLIENT_HOME=${PWD}/../test-network/organizations/peerOrganizations/org1.example.com/


while IFS=, read -r field1  
do
    #echo "asn"$field1"pw"

infoln "Registering user"
set -x
fabric-ca-client register --caname ca-org1 --id.name "asn"$field1 --id.secret "asn"$field1"pw" --id.type client --tls.certfiles ${PWD}/../test-network/organizations/fabric-ca/org1/tls-cert.pem
{ set +x; } 2>/dev/null

infoln "Generating the user msp"
set -x
fabric-ca-client enroll -u https://"asn"$field1:"asn"$field1"pw"@localhost:7054 --caname ca-org1 -M ${PWD}/../test-network/organizations/peerOrganizations/org1.example.com/users/"asn"$field1@org1.example.com/msp --tls.certfiles ${PWD}/../test-network/organizations/fabric-ca/org1/tls-cert.pem
{ set +x; } 2>/dev/null

cp ${PWD}/../test-network/organizations/peerOrganizations/org1.example.com/msp/config.yaml ${PWD}/../test-network/organizations/peerOrganizations/org1.example.com/users/"asn"$field1@org1.example.com/msp/config.yaml

cp ${PWD}/../test-network/organizations/peerOrganizations/org1.example.com/users/"asn"$field1@org1.example.com/msp/signcerts/* ${PWD}/../test-network/organizations/peerOrganizations/org1.example.com/users/"asn"$field1@org1.example.com/msp/signcerts/"asn"$field1@org1.example.com-cert.pem
cp ${PWD}/../test-network/organizations/peerOrganizations/org1.example.com/users/"asn"$field1@org1.example.com/msp/keystore/* ${PWD}/../test-network/organizations/peerOrganizations/org1.example.com/users/"asn"$field1@org1.example.com/msp/keystore/priv_sk

done < ../data/user/afrinic_users.csv
  


infoln "Enrolling Users in Org2"


export FABRIC_CA_CLIENT_HOME=${PWD}/../test-network/organizations/peerOrganizations/org2.example.com/

while IFS=, read -r field1  
do
    #echo "asn"$field1"pw"

infoln "Registering user"
set -x
fabric-ca-client register --caname ca-org2 --id.name "asn"$field1 --id.secret "asn"$field1"pw" --id.type client --tls.certfiles ${PWD}/../test-network/organizations/fabric-ca/org2/tls-cert.pem
{ set +x; } 2>/dev/null

infoln "Generating the user msp"
set -x
fabric-ca-client enroll -u https://"asn"$field1:"asn"$field1"pw"@localhost:8054 --caname ca-org2 -M ${PWD}/../test-network/organizations/peerOrganizations/org2.example.com/users/"asn"$field1@org2.example.com/msp --tls.certfiles ${PWD}/../test-network/organizations/fabric-ca/org2/tls-cert.pem
{ set +x; } 2>/dev/null

cp ${PWD}/../test-network/organizations/peerOrganizations/org2.example.com/msp/config.yaml ${PWD}/../test-network/organizations/peerOrganizations/org2.example.com/users/"asn"$field1@org2.example.com/msp/config.yaml

cp ${PWD}/../test-network/organizations/peerOrganizations/org2.example.com/users/"asn"$field1@org2.example.com/msp/signcerts/* ${PWD}/../test-network/organizations/peerOrganizations/org2.example.com/users/"asn"$field1@org2.example.com/msp/signcerts/"asn"$field1@org2.example.com-cert.pem
cp ${PWD}/../test-network/organizations/peerOrganizations/org2.example.com/users/"asn"$field1@org2.example.com/msp/keystore/* ${PWD}/../test-network/organizations/peerOrganizations/org2.example.com/users/"asn"$field1@org2.example.com/msp/keystore/priv_sk

done < ../data/user/apnic_users.csv


infoln "Enrolling Users in Org3"

export FABRIC_CA_CLIENT_HOME=${PWD}/../test-network/organizations/peerOrganizations/org3.example.com/

while IFS=, read -r field1  
do
    #echo "asn"$field1"pw"

infoln "Registering user"
set -x
fabric-ca-client register --caname ca-org3 --id.name "asn"$field1 --id.secret "asn"$field1"pw" --id.type client --tls.certfiles ${PWD}/../test-network/organizations/fabric-ca/org3/tls-cert.pem
{ set +x; } 2>/dev/null

infoln "Generating the user msp"
set -x
fabric-ca-client enroll -u https://"asn"$field1:"asn"$field1"pw"@localhost:11054 --caname ca-org3 -M ${PWD}/../test-network/organizations/peerOrganizations/org3.example.com/users/"asn"$field1@org3.example.com/msp --tls.certfiles ${PWD}/../test-network/organizations/fabric-ca/org3/tls-cert.pem
{ set +x; } 2>/dev/null

cp ${PWD}/../test-network/organizations/peerOrganizations/org3.example.com/msp/config.yaml ${PWD}/../test-network/organizations/peerOrganizations/org3.example.com/users/"asn"$field1@org3.example.com/msp/config.yaml

cp ${PWD}/../test-network/organizations/peerOrganizations/org3.example.com/users/"asn"$field1@org3.example.com/msp/signcerts/* ${PWD}/../test-network/organizations/peerOrganizations/org3.example.com/users/"asn"$field1@org3.example.com/msp/signcerts/"asn"$field1@org3.example.com-cert.pem
cp ${PWD}/../test-network/organizations/peerOrganizations/org3.example.com/users/"asn"$field1@org3.example.com/msp/keystore/* ${PWD}/../test-network/organizations/peerOrganizations/org3.example.com/users/"asn"$field1@org3.example.com/msp/keystore/priv_sk

done < ../data/user/arin_users.csv


infoln "Enrolling Users in Org4"

export FABRIC_CA_CLIENT_HOME=${PWD}/../test-network/organizations/peerOrganizations/org4.example.com/

while IFS=, read -r field1  
do
    #echo "asn"$field1"pw"

infoln "Registering user"
set -x
fabric-ca-client register --caname ca-org4 --id.name "asn"$field1 --id.secret "asn"$field1"pw" --id.type client --tls.certfiles ${PWD}/../test-network/organizations/fabric-ca/org4/tls-cert.pem
{ set +x; } 2>/dev/null

infoln "Generating the user msp"
set -x
fabric-ca-client enroll -u https://"asn"$field1:"asn"$field1"pw"@localhost:13054 --caname ca-org4 -M ${PWD}/../test-network/organizations/peerOrganizations/org4.example.com/users/"asn"$field1@org4.example.com/msp --tls.certfiles ${PWD}/../test-network/organizations/fabric-ca/org4/tls-cert.pem
{ set +x; } 2>/dev/null

cp ${PWD}/../test-network/organizations/peerOrganizations/org4.example.com/msp/config.yaml ${PWD}/../test-network/organizations/peerOrganizations/org4.example.com/users/"asn"$field1@org4.example.com/msp/config.yaml

cp ${PWD}/../test-network/organizations/peerOrganizations/org4.example.com/users/"asn"$field1@org4.example.com/msp/signcerts/* ${PWD}/../test-network/organizations/peerOrganizations/org4.example.com/users/"asn"$field1@org4.example.com/msp/signcerts/"asn"$field1@org4.example.com-cert.pem
cp ${PWD}/../test-network/organizations/peerOrganizations/org4.example.com/users/"asn"$field1@org4.example.com/msp/keystore/* ${PWD}/../test-network/organizations/peerOrganizations/org4.example.com/users/"asn"$field1@org4.example.com/msp/keystore/priv_sk

done < ../data/user/lacnic_users.csv


infoln "Enrolling Users in Org5"

export FABRIC_CA_CLIENT_HOME=${PWD}/../test-network/organizations/peerOrganizations/org5.example.com/

while IFS=, read -r field1  
do
    #echo "asn"$field1"pw"

infoln "Registering user"
set -x
fabric-ca-client register --caname ca-org5 --id.name "asn"$field1 --id.secret "asn"$field1"pw" --id.type client --tls.certfiles ${PWD}/../test-network/organizations/fabric-ca/org5/tls-cert.pem
{ set +x; } 2>/dev/null

infoln "Generating the user msp"
set -x
fabric-ca-client enroll -u https://"asn"$field1:"asn"$field1"pw"@localhost:15054 --caname ca-org5 -M ${PWD}/../test-network/organizations/peerOrganizations/org5.example.com/users/"asn"$field1@org5.example.com/msp --tls.certfiles ${PWD}/../test-network/organizations/fabric-ca/org5/tls-cert.pem
{ set +x; } 2>/dev/null

cp ${PWD}/../test-network/organizations/peerOrganizations/org5.example.com/msp/config.yaml ${PWD}/../test-network/organizations/peerOrganizations/org5.example.com/users/"asn"$field1@org5.example.com/msp/config.yaml

cp ${PWD}/../test-network/organizations/peerOrganizations/org5.example.com/users/"asn"$field1@org5.example.com/msp/signcerts/* ${PWD}/../test-network/organizations/peerOrganizations/org5.example.com/users/"asn"$field1@org5.example.com/msp/signcerts/"asn"$field1@org5.example.com-cert.pem
cp ${PWD}/../test-network/organizations/peerOrganizations/org5.example.com/users/"asn"$field1@org5.example.com/msp/keystore/* ${PWD}/../test-network/organizations/peerOrganizations/org5.example.com/users/"asn"$field1@org5.example.com/msp/keystore/priv_sk

done < ../data/user/ripe_users.csv


#   infoln "Registering user"
#   set -x
#   fabric-ca-client register --caname ca-org5 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/../test-network/organizations/fabric-ca/org5/tls-cert.pem
#   { set +x; } 2>/dev/null

#   infoln "Generating the user msp"
#   set -x
# 	fabric-ca-client enroll -u https://user1:user1pw@localhost:15054 --caname ca-org5 -M ${PWD}/../test-network/organizations/peerOrganizations/org5.example.com/users/User1@org5.example.com/msp --tls.certfiles ${PWD}/../test-network/organizations/fabric-ca/org5/tls-cert.pem
#   { set +x; } 2>/dev/null

#   cp ${PWD}/../test-network/organizations/peerOrganizations/org5.example.com/msp/config.yaml ${PWD}/../test-network/organizations/peerOrganizations/org5.example.com/users/User1@org5.example.com/msp/config.yaml

# 	infoln "Enrolling Users in Org6"

# 	export FABRIC_CA_CLIENT_HOME=${PWD}/../test-network/organizations/peerOrganizations/org6.example.com/

#   infoln "Registering user"
#   set -x
#   fabric-ca-client register --caname ca-org6 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/../test-network/organizations/fabric-ca/org6/tls-cert.pem
#   { set +x; } 2>/dev/null

#   infoln "Generating the user msp"
#   set -x
# 	fabric-ca-client enroll -u https://user1:user1pw@localhost:17054 --caname ca-org6 -M ${PWD}/../test-network/organizations/peerOrganizations/org6.example.com/users/User1@org6.example.com/msp --tls.certfiles ${PWD}/../test-network/organizations/fabric-ca/org6/tls-cert.pem
#   { set +x; } 2>/dev/null

#   cp ${PWD}/../test-network/organizations/peerOrganizations/org6.example.com/msp/config.yaml ${PWD}/../test-network/organizations/peerOrganizations/org6.example.com/users/User1@org6.example.com/msp/config.yaml


# cp ${PWD}/../test-network/organizations/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/signcerts/* ${PWD}/../test-network/organizations/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/signcerts/User1@org1.example.com-cert.pem
# cp ${PWD}/../test-network/organizations/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/keystore/* ${PWD}/../test-network/organizations/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/keystore/priv_sk

# cp ${PWD}/../test-network/organizations/peerOrganizations/org2.example.com/users/User1@org2.example.com/msp/signcerts/* ${PWD}/../test-network/organizations/peerOrganizations/org2.example.com/users/User1@org2.example.com/msp/signcerts/User1@org2.example.com-cert.pem
# cp ${PWD}/../test-network/organizations/peerOrganizations/org2.example.com/users/User1@org2.example.com/msp/keystore/* ${PWD}/../test-network/organizations/peerOrganizations/org2.example.com/users/User1@org2.example.com/msp/keystore/priv_sk

# cp ${PWD}/../test-network/organizations/peerOrganizations/org3.example.com/users/User1@org3.example.com/msp/signcerts/* ${PWD}/../test-network/organizations/peerOrganizations/org3.example.com/users/User1@org3.example.com/msp/signcerts/User1@org3.example.com-cert.pem
# cp ${PWD}/../test-network/organizations/peerOrganizations/org3.example.com/users/User1@org3.example.com/msp/keystore/* ${PWD}/../test-network/organizations/peerOrganizations/org3.example.com/users/User1@org3.example.com/msp/keystore/priv_sk

# cp ${PWD}/../test-network/organizations/peerOrganizations/org4.example.com/users/User1@org4.example.com/msp/signcerts/* ${PWD}/../test-network/organizations/peerOrganizations/org4.example.com/users/User1@org4.example.com/msp/signcerts/User1@org4.example.com-cert.pem
# cp ${PWD}/../test-network/organizations/peerOrganizations/org4.example.com/users/User1@org4.example.com/msp/keystore/* ${PWD}/../test-network/organizations/peerOrganizations/org4.example.com/users/User1@org4.example.com/msp/keystore/priv_sk

# cp ${PWD}/../test-network/organizations/peerOrganizations/org5.example.com/users/User1@org5.example.com/msp/signcerts/* ${PWD}/../test-network/organizations/peerOrganizations/org5.example.com/users/User1@org5.example.com/msp/signcerts/User1@org5.example.com-cert.pem
# cp ${PWD}/../test-network/organizations/peerOrganizations/org5.example.com/users/User1@org5.example.com/msp/keystore/* ${PWD}/../test-network/organizations/peerOrganizations/org5.example.com/users/User1@org5.example.com/msp/keystore/priv_sk

# cp ${PWD}/../test-network/organizations/peerOrganizations/org6.example.com/users/User1@org6.example.com/msp/signcerts/* ${PWD}/../test-network/organizations/peerOrganizations/org6.example.com/users/User1@org6.example.com/msp/signcerts/User1@org6.example.com-cert.pem
# cp ${PWD}/../test-network/organizations/peerOrganizations/org6.example.com/users/User1@org6.example.com/msp/keystore/* ${PWD}/../test-network/organizations/peerOrganizations/org6.example.com/users/User1@org6.example.com/msp/keystore/priv_sk
