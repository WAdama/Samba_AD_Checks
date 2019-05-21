# Samba AD Checks
Simple script senors for PRTG by Paessler to check the health of a Samba AD

The first script - ad_check_db.sh - using samba-tool dbcheck to get just the checked objects and found errors. The variant of this script - ad_check_db_mail.sh - can be used to send a mail with the full output of samba-tool dbcheck if your AD has the capability to send mails.

### Prerequisites

Be sure you have set correct logon values for SSH in your device.

I personally use "Login via private key" with an user especially for monitoring which also may use sudo for this script without a password.

![Screenshot1](https://github.com/WAdama/Samba_AD_Checks/blob/master/images/ssh_settings.png)

### Installing

Place the script to /var/prtg/scriptsxml on your Synology NAS and make it executable. (You may have to create this directory structure because PRTG expects the script here.)

```
wget https://raw.githubusercontent.com/WAdama/Samba_AD_Checks/master/ad_check_db.sh
chmod +x ad_check_db.sh
```

In PRTG create under your device which represents your Synology a SSH custom advanced senor.

Choose under "Script" this script and enter under "Parameters" the name of the volume you want to monitor: e.g. volume1.
