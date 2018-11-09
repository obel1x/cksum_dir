#!/bin/bash
# This script will scan all files in the whole directory including all files in all subdirectories
# to write its cksum in a new logfile named to match the acutal date+time under folder .cksum
# if logfolder+files are not already there, they will be created
#
#Usage
# cksum_dir.sh [comparelogfile]
#
#Parameter
# comparelogfile: Optinal Name of a logfile that is already there. Will Output differences in "diff"- Style
#
#Todos
# make more parameters
#
echo "==="

#set+create default logdir = ./.chksum
logdir="./.cksum"
if [ ! -d $logdir ] ; then
mkdir $logdir -v;
fi;

#set default logfile-name
datestr=$(date +%Y%m%d%H%M%S)
if [ ! $logfile ] ; then logfile="cksum_$datestr.log"; fi;
outfile=$logdir"/"$logfile
echo "Logfile to be used as output: "$outfile

#go and chksum directory-structure to logfile
cksumin=$(ls -ulaI$logdir) #Dont include the logdir as it will always be changed by this script
cksumout=$(echo $cksumin | cksum)
echo "CKSUM of Sourcedirectory (Listing): "$cksumout>$outfile

#now fetch all files...
echo "Fetching whole Filelist of Directory including Subdirs. Please be patient."
#create filelist in new file - needed while loop otherwise will not return anything back to this script (e.g. counters)
outpipe=$logdir"/cksum_filelist.tmp"
find . -type f -not -path "./.cksum/*" -print0 > $outpipe
counter=0;
while IFS= read -r -d $'\0' f; do
	counter=$(($counter + 1));
done < $outpipe

#and output their cksum to logfile
echo "Processing $counter Files. You can get yourself some Coffee."
while IFS= read -r -d $'\0' f; do
	cksumout=$(cksum "$f")
	echo $cksumout>>$outfile
done < $outpipe
rm $outpipe
echo "Done CKSUMMing Files to Logfile."

#we are done if no compare arg $1 is given
if [ $1 ] ; then
	echo "Now comparing current Logfile with $1. Each changed File will result in a single Line."
	diff $logdir"/"$1 $outfile
fi;
echo "End of $0. You may delete Directory $logdir if not needed any more."
echo "==="
