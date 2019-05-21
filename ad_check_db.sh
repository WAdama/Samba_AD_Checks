#!/bin/bash
#Version 1.0
IFS=" " read -a ERRORS <<< `samba-tool dbcheck | tail -1`
echo "<?xml version=\"10.0\" encoding=\"UTF-8\" ?><prtg><result><channel>Objects checked</channel><value>${ERRORS[1]}</value><unit>count</unit></result><result><channel>Errors</channel><value>${ERRORS[3]//(}</value><unit>count</unit><LimitMode>1</LimitMode><LimitMaxWarning>0</LimitMaxWarning></result></prtg>"
