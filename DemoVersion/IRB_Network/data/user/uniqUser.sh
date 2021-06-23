#!/bin/bash 
comm -23 <(sort afrinic/afrinic_2016.csv) <(sort afrinic/afrinic_2015.csv) > afrinic/reduced/afrinic_2016.csv
comm -23 <(sort afrinic/afrinic_2017.csv) <(sort afrinic/afrinic_2016.csv) > afrinic/reduced/afrinic_2017.csv
comm -23 <(sort afrinic/afrinic_2018.csv) <(sort afrinic/afrinic_2017.csv) > afrinic/reduced/afrinic_2018.csv
comm -23 <(sort afrinic/afrinic_2019.csv) <(sort afrinic/afrinic_2018.csv) > afrinic/reduced/afrinic_2019.csv
comm -23 <(sort afrinic/afrinic_2020.csv) <(sort afrinic/afrinic_2019.csv) > afrinic/reduced/afrinic_2020.csv
comm -23 <(sort afrinic/afrinic_2021.csv) <(sort afrinic/afrinic_2020.csv) > afrinic/reduced/afrinic_2021.csv

comm -23 <(sort apnic/apnic_2016.csv) <(sort apnic/apnic_2015.csv) > apnic/reduced/apnic_2016.csv
comm -23 <(sort apnic/apnic_2017.csv) <(sort apnic/apnic_2016.csv) > apnic/reduced/apnic_2017.csv
comm -23 <(sort apnic/apnic_2018.csv) <(sort apnic/apnic_2017.csv) > apnic/reduced/apnic_2018.csv
comm -23 <(sort apnic/apnic_2019.csv) <(sort apnic/apnic_2018.csv) > apnic/reduced/apnic_2019.csv
comm -23 <(sort apnic/apnic_2020.csv) <(sort apnic/apnic_2019.csv) > apnic/reduced/apnic_2020.csv
comm -23 <(sort apnic/apnic_2021.csv) <(sort apnic/apnic_2020.csv) > apnic/reduced/apnic_2021.csv

comm -23 <(sort arin/arin_2016.csv) <(sort arin/arin_2015.csv) > arin/reduced/arin_2016.csv
comm -23 <(sort arin/arin_2017.csv) <(sort arin/arin_2016.csv) > arin/reduced/arin_2017.csv
comm -23 <(sort arin/arin_2018.csv) <(sort arin/arin_2017.csv) > arin/reduced/arin_2018.csv
comm -23 <(sort arin/arin_2019.csv) <(sort arin/arin_2018.csv) > arin/reduced/arin_2019.csv
comm -23 <(sort arin/arin_2020.csv) <(sort arin/arin_2019.csv) > arin/reduced/arin_2020.csv
comm -23 <(sort arin/arin_2021.csv) <(sort arin/arin_2020.csv) > arin/reduced/arin_2021.csv

comm -23 <(sort ripe/ripe_2016.csv) <(sort ripe/ripe_2015.csv) > ripe/reduced/ripe_2016.csv
comm -23 <(sort ripe/ripe_2017.csv) <(sort ripe/ripe_2016.csv) > ripe/reduced/ripe_2017.csv
comm -23 <(sort ripe/ripe_2018.csv) <(sort ripe/ripe_2017.csv) > ripe/reduced/ripe_2018.csv
comm -23 <(sort ripe/ripe_2019.csv) <(sort ripe/ripe_2018.csv) > ripe/reduced/ripe_2019.csv
comm -23 <(sort ripe/ripe_2020.csv) <(sort ripe/ripe_2019.csv) > ripe/reduced/ripe_2020.csv
comm -23 <(sort ripe/ripe_2021.csv) <(sort ripe/ripe_2020.csv) > ripe/reduced/ripe_2021.csv

comm -23 <(sort lacnic/lacnic_2016.csv) <(sort lacnic/lacnic_2015.csv) > lacnic/reduced/lacnic_2016.csv
comm -23 <(sort lacnic/lacnic_2017.csv) <(sort lacnic/lacnic_2016.csv) > lacnic/reduced/lacnic_2017.csv
comm -23 <(sort lacnic/lacnic_2018.csv) <(sort lacnic/lacnic_2017.csv) > lacnic/reduced/lacnic_2018.csv
comm -23 <(sort lacnic/lacnic_2019.csv) <(sort lacnic/lacnic_2018.csv) > lacnic/reduced/lacnic_2019.csv
comm -23 <(sort lacnic/lacnic_2020.csv) <(sort lacnic/lacnic_2019.csv) > lacnic/reduced/lacnic_2020.csv
comm -23 <(sort lacnic/lacnic_2021.csv) <(sort lacnic/lacnic_2020.csv) > lacnic/reduced/lacnic_2021.csv