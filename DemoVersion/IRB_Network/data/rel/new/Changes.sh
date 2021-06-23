#!/bin/bash

awk -F, '$3== "RIPE" {print $1,$2,$3,$4,$5}' 2016-new.csv  |sort -u >ripe/ripe_2016_new.csv
awk -F, '$3== "ARIN" {print $1,$2,$3,$4,$5}' 2016-new.csv  |sort -u >arin/arin_2016_new.csv
awk -F, '$3== "LACNIC" {print $1,$2,$3,$4,$5}' 2016-new.csv  |sort -u >lacnic/lacnic_2016_new.csv
awk -F, '$3== "AFRINIC" {print $1,$2,$3,$4,$5}' 2016-new.csv  |sort -u >afrinic/afrinic_2016_new.csv
awk -F, '$3== "APNIC" {print $1,$2,$3,$4,$5}' 2016-new.csv  |sort -u >apnic/apnic_2016_new.csv



awk -F, '$3== "RIPE" {print $1,$2,$3,$4,$5}' 2017-new.csv  |sort -u >ripe/ripe_2017_new.csv
awk -F, '$3== "ARIN" {print $1,$2,$3,$4,$5}' 2017-new.csv  |sort -u >arin/arin_2017_new.csv
awk -F, '$3== "LACNIC" {print $1,$2,$3,$4,$5}' 2017-new.csv  |sort -u >lacnic/lacnic_2017_new.csv
awk -F, '$3== "AFRINIC" {print $1,$2,$3,$4,$5}' 2017-new.csv  |sort -u >afrinic/afrinic_2017_new.csv
awk -F, '$3== "APNIC" {print $1,$2,$3,$4,$5}' 2017-new.csv  |sort -u >apnic/apnic_2017_new.csv


awk -F, '$3== "RIPE" {print $1,$2,$3,$4,$5}' 2018-new.csv  |sort -u >ripe/ripe_2018_new.csv
awk -F, '$3== "ARIN" {print $1,$2,$3,$4,$5}' 2018-new.csv  |sort -u >arin/arin_2018_new.csv
awk -F, '$3== "LACNIC" {print $1,$2,$3,$4,$5}' 2018-new.csv  |sort -u >lacnic/lacnic_2018_new.csv
awk -F, '$3== "AFRINIC" {print $1,$2,$3,$4,$5}' 2018-new.csv  |sort -u >afrinic/afrinic_2018_new.csv
awk -F, '$3== "APNIC" {print $1,$2,$3,$4,$5}' 2018-new.csv  |sort -u >apnic/apnic_2018_new.csv


awk -F, '$3== "RIPE" {print $1,$2,$3,$4,$5}' 2019-new.csv  |sort -u >ripe/ripe_2019_new.csv
awk -F, '$3== "ARIN" {print $1,$2,$3,$4,$5}' 2019-new.csv  |sort -u >arin/arin_2019_new.csv
awk -F, '$3== "LACNIC" {print $1,$2,$3,$4,$5}' 2019-new.csv  |sort -u >lacnic/lacnic_2019_new.csv
awk -F, '$3== "AFRINIC" {print $1,$2,$3,$4,$5}' 2019-new.csv  |sort -u >afrinic/afrinic_2019_new.csv
awk -F, '$3== "APNIC" {print $1,$2,$3,$4,$5}' 2019-new.csv  |sort -u >apnic/apnic_2019_new.csv

awk -F, '$3== "RIPE" {print $1,$2,$3,$4,$5}' 2020-new.csv  |sort -u >ripe/ripe_2020_new.csv
awk -F, '$3== "ARIN" {print $1,$2,$3,$4,$5}' 2020-new.csv  |sort -u >arin/arin_2020_new.csv
awk -F, '$3== "LACNIC" {print $1,$2,$3,$4,$5}' 2020-new.csv  |sort -u >lacnic/lacnic_2020_new.csv
awk -F, '$3== "AFRINIC" {print $1,$2,$3,$4,$5}' 2020-new.csv  |sort -u >afrinic/afrinic_2020_new.csv
awk -F, '$3== "APNIC" {print $1,$2,$3,$4,$5}' 2020-new.csv  |sort -u >apnic/apnic_2020_new.csv

awk -F, '$3== "RIPE" {print $1,$2,$3,$4,$5}' 2021-new.csv  |sort -u >ripe/ripe_2021_new.csv
awk -F, '$3== "ARIN" {print $1,$2,$3,$4,$5}' 2021-new.csv  |sort -u >arin/arin_2021_new.csv
awk -F, '$3== "LACNIC" {print $1,$2,$3,$4,$5}' 2021-new.csv  |sort -u >lacnic/lacnic_2021_new.csv
awk -F, '$3== "AFRINIC" {print $1,$2,$3,$4,$5}' 2021-new.csv  |sort -u >afrinic/afrinic_2021_new.csv
awk -F, '$3== "APNIC" {print $1,$2,$3,$4,$5}' 2021-new.csv  |sort -u >apnic/apnic_2021_new.csv