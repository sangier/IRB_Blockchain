#!/bin/bash

awk -F, '$4== "RIPE" {print $1,$2,$4,substr($5, 1, length($5)-1),$3}' 20151201.as-rel2.csv  |sort -u >ripe/ripe_2015_new.csv
awk -F, '$4== "ARIN" {print $1,$2,$4,substr($5, 1, length($5)-1),$3}' 20151201.as-rel2.csv  |sort -u >arin/arin_2015_new.csv
awk -F, '$4== "LACNIC" {print $1,$2,$4,substr($5, 1, length($5)-1),$3}' 20151201.as-rel2.csv  |sort -u >lacnic/lacnic_2015_new.csv
awk -F, '$4== "AFRINIC" {print $1,$2,$4,substr($5, 1, length($5)-1),$3}' 20151201.as-rel2.csv  |sort -u >afrinic/afrinic_2015_new.csv
awk -F, '$4== "APNIC" {print $1,$2,$4,substr($5, 1, length($5)-1),$3}' 20151201.as-rel2.csv  |sort -u >apnic/apnic_2015_new.csv
