# Dokuwiki Docker image based on Alpine v.3.12

##--------------------------------------------

!!! LDAP SUPPORT  IS UNDER CONSTRUCTION !!!

##--------------------------------------------


## Intro
DokuWiki is a simple to use and highly versatile Open Source wiki software that doesn't require
a database. It is loved by users for its clean and readable syntax. The ease of maintenance,
backup and integration makes it an administrator's favorite. Built in access controls and
authentication connectors make DokuWiki especially useful in the enterprise context and
the large number of plugins contributed by its vibrant community allow for a broad
range of use cases beyond a traditional wiki.


[ Written by @TimRabl ]( https://github.com/timrabl/ "@TimRabl GitHub")

## Make
For easier updating and deployment there is an `Makefile`.
This makefile supports the follwing task's:

#### get-stable
Pull the latest version from the provided path ( **by default:** https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz),
writes it into the tmp directory and extract it into the **image-files/dokuwiki-stable/** folder.

#### get-stable
Pull the latest release-candidate version from the provided path ( **by default:** https://download.dokuwiki.org/src/dokuwiki/dokuwiki-rc.tgz),
writes it into the tmp directory and extract it into the **image-files/dokuwiki-release-canidate/** folder.

#### build-latest ( stable )
Build the latest / stable docker image and Tag it with **latest**.
</br>
`docker build -t dokuwiki:latest --build-arg VERSION=latest image-files/`

#### build-latest-installer
Build the latest / stable docker image ( including the install.php ) and tag it with **latest-installer**.
</br>
`docker build -t dokuwiki:latest-installer --build-arg VERSION=latest --build-arg INSTALLER=true image-files/`

#### build-latest-ldap
Build the latest / stable docker image and enables LDAP options in the Dokuwiki.php configuration file.
</br>
**=> this enables LDAP enviroment variables for LDAP Support**
</br>
`docker build -t dokuwiki:latest-ldap --build-arg VERSION=latest --build-arg LDAP=true image-files/`

#### build-latest-installer-ldap
Build the latest / stable docker image ( including the install.php ) and enables LDAP options in the Dokuwiki.php configuration file.
</br>
**=> this enables LDAP enviroment variables for LDAP Support**
</br>
`docker build -t dokuwiki:latest-installer-ldap --build-arg VERSION=latest --build-arg INSTALLER=true --build-arg LDAP=true image-files/`

#### build-rc ( release-canidate )
Build the release-canidate docker image and Tag it with **rc**.
</br>
`docker build -t dokuwiki:rc --build-arg VERSION=latest image-files/`

#### build-rc-installer
Build the release-candidate docker image ( including the install.php ) and tag it with **release-candidate-installer**.
</br>
`docker build -t dokuwiki:rc-installer --build-arg VERSION=latest --build-arg INSTALLER=true image-files/`

#### build-rc-ldap
Build the release-canidate docker image and enables LDAP options in the Dokuwiki.php configuration file.
</br>
**=> this enables LDAP enviroment variables for LDAP Support**
</br>
`docker build -t dokuwiki:rc-ldap --build-arg VERSION=latest --build-arg LDAP=true image-files/`

#### build-rc-installer-ldap
Build the release-candidate docker image ( including the install.php ) and enables LDAP options in the Dokuwiki.php configuration file.
</br>
**=> this enables LDAP enviroment variables for LDAP Support**
</br>
`docker build -t dokuwiki:rc-installer-ldap --build-arg VERSION=latest --build-arg INSTALLER=true --build-arg LDAP=true image-files/`

## enviroment varibales
These are the main enviroment variables which can / must be passed to the docker image.
</br>
**Required vars are marked with an * at the end !**

| Variable | Explanation |
| -------- | ----------- |
| **openssl:** ||
| SSL_EXPIRE **\*** | The time period until the certificate becomes invalid |
| SSL_C | Country code (e.q. US, GB, DE, ...) |
| SSL_ST | State (e.q. London ) |
| SSL_L | Location (e.q. London ) |
| SSL_O | Organization (e.q. Example Organisation ) |
| SSL_OU | Organizational Unit (e.q. IT Department ) |
| SSL_CN **\*** | Common Name (e.q. example.com ) |
| **ldap:** ||
| comming | soon |

## docker-compose
For easier use there is a docker-compose.yml file under the **compose-files/** folder. This file contains all
cofiguration for starting the dokuwiki and normally no extra configuration on this file is needed. Please be sure
to define all neccessary environment variables in the .env file. There's a symlink called **environment**
which points to the .env file ( maybe this makes it easier ).

The following enviroment varibales are supported:
**Required vars are marked with an * at the end !**

| Env | Description |
|-----|-------------|
| **image stuff:** ||
| VERSION | This defines the version of the used docker image ( all version are listed above ). |
| **openssl:** ||
| SSL_EXPIRE **\*** | The time period until the certificate becomes invalid |
| SSL_C | Country code (e.q. US, GB, DE, ...) |
| SSL_ST | State (e.q. London ) |
| SSL_L | Location (e.q. London ) |
| SSL_O | Organization (e.q. Example Organisation ) |
| SSL_OU | Organizational Unit (e.q. IT Department ) |
| SSL_CN **\*** | Common Name (e.q. example.com ) |
