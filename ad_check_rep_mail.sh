#!/bin/bash
#Version 1.0
RECIPIENT=$1
REPL=`samba-tool drs showrepl`
TOTAL=0
while IFS=" " read -ra LINE
do
   TOTAL=$((TOTAL + LINE))
done < <(echo "$REPL" | grep consecutive)
echo "<?xml version=\"10.0\" encoding=\"UTF-8\" ?><prtg><result><channel>Consecutive Error(s)</channel><value>$TOTAL</value><unit>count</unit><LimitMode>1</LimitMode><LimitMaxWarning>0</LimitMaxWarning></result></prtg>"
if [ $TOTAL -gt "0" ]
then
	echo "$REPL" | mail -s"AD Replication Error(s) detected" $RECIPIENT
fi