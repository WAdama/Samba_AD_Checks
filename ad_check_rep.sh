#!/bin/bash
#Version 1.0.1
REPL=`samba-tool drs showrepl | grep consecutive`
TOTAL=0
while IFS=" " read -ra LINE
do
   TOTAL=$((TOTAL + LINE))
done < <(printf "$REPL")
if [ $TOTAL == 0 ]
then STATUS=0
else STATUS=1
fi
echo "<?xml version=\"10.0\" encoding=\"UTF-8\" ?><prtg><result><channel>Status</channel><value>$STATUS</value><ValueLookup>prtg.standardlookups.nas.adstatus</ValueLookup></result><result><channel>Consecutive Error(s)</channel><value>$TOTAL</value><unit>count</unit></result></prtg>"
