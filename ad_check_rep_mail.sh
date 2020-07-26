#!/bin/bash
#Version 1.0.2
RECIPIENT=$1
SAMBA_BIN="/usr/local/samba/bin"
REPL=`$SAMBA_BIN/samba-tool drs showrepl`
TOTAL=0
while IFS=" " read -ra LINE
do
   TOTAL=$((TOTAL + LINE))
done < <(echo "$REPL" | grep consecutive)
if [ $TOTAL -gt "0" ]
then
	echo "$REPL" | mail -s"AD Replication Error(s) detected" $RECIPIENT
	STATUS=1
else
	STATUS=0
fi
echo "<?xml version=\"10.0\" encoding=\"UTF-8\" ?><prtg><result><channel>Status</channel><value>$STATUS</value><ValueLookup>prtg.standardlookups.nas.adstatus</ValueLookup></result><result><channel>Consecutive Error(s)</channel><value>$TOTAL</value><unit>count</unit></result></prtg>"
