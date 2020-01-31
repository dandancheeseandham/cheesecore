FILE=railcore_backup             
NAME=${FILE%.*}
DATE=`date +%y-%m-%d`         
NEWFILE=${NAME}_${DATE}
mkdir $NEWFILE
./rfm backup -domain railcore.local -exclude 0:/gcodes ./$NEWFILE
tar -zcvf $NEWFILE.tar.gz $NEWFILE
rm -rf $NEWFILE
