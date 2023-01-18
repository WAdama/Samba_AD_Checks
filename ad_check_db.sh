#!/bin/bash
#Version 1.0.3
SAMTOOL=$(which samba-tool)
IFS=" " read -r -a ERRORS <<< "$("$SAMTOOL" dbcheck | tail -1)"
if [ "${ERRORS[3]//(}" == 0 ]
then STATUS=0
else STATUS=1
fi
echo "<?xml version=\"10.0\" encoding=\"UTF-8\" ?><prtg><result><channel>Status</channel><value>$STATUS</value><ValueLookup>prtg.standardlookups.nas.adstatus</ValueLookup></result><result><channel>Objects checked</channel><value>${ERRORS[1]}</value><unit>count</unit></result><result><channel>Errors</channel><value>${ERRORS[3]//(}</value><unit>count</unit></result></prtg>"
