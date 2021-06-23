#!/bin/bash
nRecord=0
batch=2500
for ((i=0; i<601; i++))
do
       limite=$(($batch*$i))

       Time1=$(curl -X GET \
               --output /dev/null \
                       --write-out '%{time_total}' \
                       http://admin:adminpw@127.0.0.1:5984/mychannel_aspaircontract/_all_docs?limit=$limite )

       nRecord=$(curl -X GET http://admin:adminpw@127.0.0.1:5984/mychannel_aspaircontract/_all_docs?limit=$limite | grep -i -o key | wc -l)
      if [ $nRecord -lt $limite ]; then
           echo "Exiting"
           exit 1
        fi

       curl -i http://admin:adminpw@127.0.0.1:5984/mychannel_aspaircontract/_all_docs?limit=$limite > /home/sangieri/6OrgNetwork/myNetwork/data/log/db.json

       size=$(ls -s  /home/sangieri/6OrgNetwork/myNetwork/data/log/db.json | grep -i db.json | cut -d ' ' -f 1)

       echo "Record Number: "$nRecord
       echo "TimeToRead: "$Time1
       echo "MemorySize:" $size
       echo $nRecord","$Time1","$size >/home/sangieri/6OrgNetwork/myNetwork/data/log/AllSizeTimeToRead.txt

done

curl -i http://admin:adminpw@127.0.0.1:5984/mychannel_aspaircontract/_all_docs?include_docs=true > /home/sangieri/6OrgNetwork/myNetwork/data/log/db.json