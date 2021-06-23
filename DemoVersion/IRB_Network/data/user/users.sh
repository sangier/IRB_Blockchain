#!/bin/bash

grep "RIPE" as_numbers_Assignments.csv | cut -d "," -f 1 |sort -u >ripe_users.csv
grep "ARIN" as_numbers_Assignments.csv | cut -d "," -f 1 |sort -u >arin_users.csv
grep "AFRINIC" as_numbers_Assignments.csv | cut -d "," -f 1 |sort -u >afrinic_users.csv
grep "APNIC" as_numbers_Assignments.csv | cut -d "," -f 1 |sort -u >apnic_users.csv
grep "LACNIC" as_numbers_Assignments.csv | cut -d "," -f 1 |sort -u >lacnic_users.csv
