#!/bin/bash

curl -i curl -i http://admin:adminpw@127.0.0.1:5984/mychannel_aspaircontract/_all_docs?include_docs=true  | tee /home/sangieri/IRB_Blockchain/data/log/db.json

