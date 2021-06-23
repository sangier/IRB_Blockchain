#!/bin/bash

awk -F, '$4== "RIPE" {print $1,$2,$4,$5,$6}' 2016-changes.csv  |sort -u >ripe/ripe_2016_changes.csv
awk -F, '$4== "ARIN" {print $1,$2,$4,$5,$6}' 2016-changes.csv  |sort -u >arin/arin_2016_changes.csv
awk -F, '$4== "LACNIC" {print $1,$2,$4,$5,$6}' 2016-changes.csv  |sort -u >lacnic/lacnic_2016_changes.csv
awk -F, '$4== "AFRINIC" {print $1,$2,$4,$5,$6}' 2016-changes.csv  |sort -u >afrinic/afrinic_2016_changes.csv
awk -F, '$4== "APNIC" {print $1,$2,$4,$5,$6}' 2016-changes.csv  |sort -u >apnic/apnic_2016_changes.csv



awk -F, '$4== "RIPE" {print $1,$2,$4,$5,$6}' 2017-changes.csv  |sort -u >ripe/ripe_2017_changes.csv
awk -F, '$4== "ARIN" {print $1,$2,$4,$5,$6}' 2017-changes.csv  |sort -u >arin/arin_2017_changes.csv
awk -F, '$4== "LACNIC" {print $1,$2,$4,$5,$6}' 2017-changes.csv  |sort -u >lacnic/lacnic_2017_changes.csv
awk -F, '$4== "AFRINIC" {print $1,$2,$4,$5,$6}' 2017-changes.csv  |sort -u >afrinic/afrinic_2017_changes.csv
awk -F, '$4== "APNIC" {print $1,$2,$4,$5,$6}' 2017-changes.csv  |sort -u >apnic/apnic_2017_changes.csv


awk -F, '$4== "RIPE" {print $1,$2,$4,$5,$6}' 2018-changes.csv  |sort -u >ripe/ripe_2018_changes.csv
awk -F, '$4== "ARIN" {print $1,$2,$4,$5,$6}' 2018-changes.csv  |sort -u >arin/arin_2018_changes.csv
awk -F, '$4== "LACNIC" {print $1,$2,$4,$5,$6}' 2018-changes.csv  |sort -u >lacnic/lacnic_2018_changes.csv
awk -F, '$4== "AFRINIC" {print $1,$2,$4,$5,$6}' 2018-changes.csv  |sort -u >afrinic/afrinic_2018_changes.csv
awk -F, '$4== "APNIC" {print $1,$2,$4,$5,$6}' 2018-changes.csv  |sort -u >apnic/apnic_2018_changes.csv


awk -F, '$4== "RIPE" {print $1,$2,$4,$5,$6}' 2019-changes.csv  |sort -u >ripe/ripe_2019_changes.csv
awk -F, '$4== "ARIN" {print $1,$2,$4,$5,$6}' 2019-changes.csv  |sort -u >arin/arin_2019_changes.csv
awk -F, '$4== "LACNIC" {print $1,$2,$4,$5,$6}' 2019-changes.csv  |sort -u >lacnic/lacnic_2019_changes.csv
awk -F, '$4== "AFRINIC" {print $1,$2,$4,$5,$6}' 2019-changes.csv  |sort -u >afrinic/afrinic_2019_changes.csv
awk -F, '$4== "APNIC" {print $1,$2,$4,$5,$6}' 2019-changes.csv  |sort -u >apnic/apnic_2019_changes.csv

awk -F, '$4== "RIPE" {print $1,$2,$4,$5,$6}' 2020-changes.csv  |sort -u >ripe/ripe_2020_changes.csv
awk -F, '$4== "ARIN" {print $1,$2,$4,$5,$6}' 2020-changes.csv  |sort -u >arin/arin_2020_changes.csv
awk -F, '$4== "LACNIC" {print $1,$2,$4,$5,$6}' 2020-changes.csv  |sort -u >lacnic/lacnic_2020_changes.csv
awk -F, '$4== "AFRINIC" {print $1,$2,$4,$5,$6}' 2020-changes.csv  |sort -u >afrinic/afrinic_2020_changes.csv
awk -F, '$4== "APNIC" {print $1,$2,$4,$5,$6}' 2020-changes.csv  |sort -u >apnic/apnic_2020_changes.csv

awk -F, '$4== "RIPE" {print $1,$2,$4,$5,$6}' 2021-changes.csv  |sort -u >ripe/ripe_2021_changes.csv
awk -F, '$4== "ARIN" {print $1,$2,$4,$5,$6}' 2021-changes.csv  |sort -u >arin/arin_2021_changes.csv
awk -F, '$4== "LACNIC" {print $1,$2,$4,$5,$6}' 2021-changes.csv  |sort -u >lacnic/lacnic_2021_changes.csv
awk -F, '$4== "AFRINIC" {print $1,$2,$4,$5,$6}' 2021-changes.csv  |sort -u >afrinic/afrinic_2021_changes.csv
awk -F, '$4== "APNIC" {print $1,$2,$4,$5,$6}' 2021-changes.csv  |sort -u >apnic/apnic_2021_changes.csv