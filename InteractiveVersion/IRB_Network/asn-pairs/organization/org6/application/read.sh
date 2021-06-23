#!/bin/bash

curl -i curl -i http://admin:adminpw@127.0.0.1:5984/mychannel_aspaircontract/_all_docs?include_docs=true  | tee /home/sangieri/6OrgNetwork/myNetwork/data/log/db.json

