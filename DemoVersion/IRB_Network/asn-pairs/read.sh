#!/bin/bash

Time1=$(curl -X GET \
                --output /dev/null \
                        --write-out '%{time_total}' \
                        http://admin:adminpw@127.0.0.1:5984/mychannel_aspaircontract/_all_docs?include_docs=true )

nRecord=$(curl -X GET http://admin:adminpw@127.0.0.1:5984/mychannel_aspaircontract/_all_docs?include_docs=true | grep -i -o key | wc -l)


curl -i http://admin:adminpw@127.0.0.1:5984/mychannel_aspaircontract/_all_docs > home/sangieri/6OrgNetwork/myNetwork/data/log/db.json

size=$(ls -s  home/sangieri/6OrgNetwork/myNetwork/data/log/db.json | grep -i db.json | cut -d ' ' -f 1)

echo "Record Number: "$nRecord
echo "TimeToRead: "$Time1
echo $nRecord","$Time1","$size >>/home/sangieri/6OrgNetwork/myNetwork/data/log/SizeTimeToRead.txt
