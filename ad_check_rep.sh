#!/bin/bash
#Version 1.0
REPL=`samba-tool drs showrepl | grep consecutive`
TOTAL=0
while IFS=" " read -ra LINE
do
   TOTAL=$((TOTAL + LINE))
done < <(printf "$REPL")
echo "<?xml version=\"10.0\" encoding=\"UTF-8\" ?><prtg><result><channel>Consecutive Error(s)</channel><value>$TOTAL</value><unit>count</unit><LimitMode>1</LimitMode><LimitMaxWarning>0</LimitMaxWarning></result></prtg>"
