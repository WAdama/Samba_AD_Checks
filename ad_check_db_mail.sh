#!/bin/bash
#Version 1.0
RECIPIENT=$1
DBCHECK=`samba-tool dbcheck`
IFS=" " read -a ERRORS <<< `echo "$DBCHECK" | tail -1`
echo "<?xml version=\"10.0\" encoding=\"UTF-8\" ?><prtg><result><channel>Objects checked</channel><value>${ERRORS[1]}</value><unit>count</unit></result><result><channel>Errors</channel><value>${ERRORS[3]//(}</value><unit>count</unit><LimitMode>1</LimitMode><LimitMaxWarning>0</LimitMaxWarning></result></prtg>"
if [ ${ERRORS[3]//(} -gt 0 ]
then
	echo "$DBCHECK" | mail -s"AD DB Error(s) detected" $RECIPIENT
fi

