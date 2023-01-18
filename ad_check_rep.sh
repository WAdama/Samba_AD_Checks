#!/bin/bash
# Version 1.0.1
SAMTOOL=$(which samba-tool)
REPLICATION=$($SAMTOOL drs showrepl --json | jq -c .)
REPSFROM=$(echo "$REPLICATION" | jq -c .repsFrom[])
TIME=$(date +%s)

echo "<?xml version=\"10.0\" encoding=\"UTF-8\" ?><prtg>"
for REPS in $(echo "${REPSFROM}" | jq -r '. | @base64'); do
    _jq() {
     echo "${REPS}" | base64 --decode | jq -r "${1}"
    }
   REPS=$(_jq '.')
   DSA=$(cut -d'\' -f 2 <<< "$(echo "$REPS" | jq -c -r '.DSA')")
   NC=$(cut -d'=' -f 2 <<< "$(cut -d',' -f 1 <<< "$(echo "$REPS" | jq -c -r '.["NC dn"]')")")
   LASTATTEMPT=$(($(date -d "$(echo "$REPS" | jq -c -r '.["last attempt time"]')" +%s)-"$TIME"))
   LASTSUCCESS=$(($(date -d "$(echo "$REPS" | jq -c -r '.["last success"]')" +%s)-"$TIME"))
   case $(echo "$REPS" | jq -c -r '.["last attempt message"]') in
		*"was successful"*) LASTMESSAGE="1" ;;
		*"failed"*) LASTMESSAGE="2" ;;
   esac
   case $(echo "$REPS" | jq -c -r '.["is deleted"]') in
		*"false"*) ISDELETED="1" ;;
		*"true"*) ISDELETED="2" ;;
   esac
   CONFAIL=$(echo "$REPS" | jq -c -r '.["consecutive failures"]')
   echo "
   <result><channel>$NC / $DSA Result</channel><value>$LASTMESSAGE</value><valuelookup>prtg.standardlookups.samba.adstatus</valuelookup><ShowChart>0</ShowChart></result>
   <result><channel>$NC / $DSA Last Attempt</channel><value>$LASTATTEMPT</value><unit>TimeSeconds</unit></result>
   <result><channel>$NC / $DSA Last Success</channel><value>$LASTSUCCESS</value><unit>TimeSeconds</unit></result>
   <result><channel>$NC / $DSA Consecutive Failures</channel><value>$CONFAIL</value><unit>Count</unit><LimitMaxWarning>1</LimitMaxWarning><LimitMaxError>10</LimitMaxError><LimitMode>1</LimitMode></result>
   <result><channel>$NC / $DSA Is Deleted</channel><value>$ISDELETED</value><valuelookup>prtg.standardlookups.yesno.statenook</valuelookup><ShowChart>0</ShowChart></result>
   "
done
echo "</prtg>"
exit
