# docker-dokuwiki-alpine

Dokuwiki docker image inside a alpine image (v3.12)  
**Unencrypted traffic is not supported !**  

[Written by @TimRabl](https://github.com/timrabl/ "@TimRabl GitHub")  
 <br></br>


## Versions / Tags

| Tag | Description |
|-----|-------------|
| stable | Image based on the stable dokuwiki version |
| stable-installer | Pretty much the same as the stable version above, except for the missing *install.php* file |
| rc | Image based on the release candidate version of dokuwiki, the actual release candidate version is provided above |
|rc-installer | Pretty much the same again... based on the release-candidate version of dokuwiki but withou the *install.php* file |
| *coming soon:*| |
| stable-ldap | Stable image with *ldap* login support |
| rc-ldap | Release candidate image with *ldap* support |

`-v {VOLUME_NAME}:/var/www/localhost/htdocs/data`

## Environment

| Variable | Explanation |
| -------- | ----------- |
| *openssl:* | |
| SSL_EXPIRE | The time period until the certicficate becomes invalid |
| SSL_C | Country code (e.q. US, GB, DE, ...) |
| SSL_ST | State (e.q. London ) |
| SSL_L | Location (e.q. London ) |
| SSL_O | Organization (e.q. Example Organisation ) |
| SSL_OU | Organizational Unit (e.q. IT Department ) |
| SSL_CN | Common Name (e.q. example.com ) |