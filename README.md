# docker-dokuwiki-alpine

Dokuwiki docker image inside a alpine image (v3.12)  
**Unencrypted traffic is not supported !**  

[Written by @TimRabl](https://github.com/timrabl/ "@TimRabl GitHub")  
 <br></br>


## Version / Tags

#### stable

The stable dokuwiki version without the `ìnstall.php`.  
This means you need to provide a existing dokuwiki data volume to work.
This is done with:

`-v {VOLUME_NAME}:/var/www/localhost/htdocs/data`

#### stable-installer

The same version as the previous mentioned stable version, but with the `install.php`.
This means you don't have to provide a data volume but it's recommend if you want to prevent data loss.

#### rc

The *release candidate 3 ( Hogfather )* Version without the `install.php`.
As mentioned before, without the installer you need a existing data volume.
Look at the stable section to see how to do this.


#### rc-installer

The *release candidate 3 ( Hogfather )* Version with the default installer.
As mentioned before, it's recommended to provide a data vaolume.
Look at the stable section to see how to do this.


## Environment
**Useable compose enviroment variables:**

| Variable | Explanation |
| -------- | ----------- |
| *apache:* ||
| SERVER_NAME | the server's comon name for SSL certificates |
<br></br>

**Optional in the distant future:**

| Variable | Explanation |
| -------- | ----------- |
| *ldap:* ||
| LDAP_BIND_DN | Your LDAP **bindDN** for authentication with a LDAP server. Make sure that the LDAP server is reachable from inside this container |
| LDAP_BIND_PW | Your LDAP **bindPW** (the password for the **bindDN**)|
<br></br>

