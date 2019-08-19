#!/bin/bash
#Version 1.0.1
RECIPIENT=$1
DBCHECK=`samba-tool dbcheck`
IFS=" " read -a ERRORS <<< `echo "$DBCHECK" | tail -1`
if [ ${ERRORS[3]//(} -gt 0 ]
then
	echo "$DBCHECK" | mail -s"AD DB Error(s) detected" $RECIPIENT
	STATUS=1
else 
	STATUS=0
fi
echo "<?xml version=\"10.0\" encoding=\"UTF-8\" ?><prtg><result><channel>Status</channel><value>$STATUS</value><ValueLookup>prtg.standardlookups.nas.adstatus</ValueLookup></result><result><channel>Objects checked</channel><value>${ERRORS[1]}</value><unit>count</unit></result><result><channel>Errors</channel><value>${ERRORS[3]//(}</value><unit>count</unit></result></prtg>"
