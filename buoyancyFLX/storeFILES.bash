#!/bin/bash

cyear=$1
ftype=$2

if [ ! -d JOBS ] ; then mkdir JOBS ; fi 
if [ ! -d OUT ] ; then mkdir OUT ; fi 


for zmonth in `seq 1 12 ` ; do 

    month=`printf "%02d" $zmonth`

    echo 
    echo "             >>>>> Zip month: ${month} from the year ${cyear}" 
    echo 

    # Loop over the frequency
    for freq in `echo 1d `  ; do 
    
         # Loop over file type 
         sed -e "s/<XXMONTHXX>/${month}/" \
             -e "s/<XXFREQXX>/${freq}/"  \
             -e "s/<XXYEARXX>/${cyear}/" \
             -e "s/<XXFTYPEXX>/${ftype}/"  store_file.template > ./JOBS/mv2store_${ftype}_${month}_${cyear}.bash
             
         ccc_msub ./JOBS/mv2store_${ftype}_${month}_${cyear}.bash
         
    done 

done 
