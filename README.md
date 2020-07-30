
# What is this ?
This is the repository for the automated [Dockerhub](https://hub.docker.com/r/timrabl/dokuwiki "timrabl/dokuwiki on dockerhub.com") build.
The automatic build process in the dockerhub builds the docker images which
provides a dokuwiki instalation on an apache web server in an alpine linux
docker container. In addition, functionalities such as TLS/SSL, LDAP
and in the future also proxy will be supported.
Improvements and suggestions are welcome.


Current used alpine version: [v.3.12](https://alpinelinux.org/posts/Alpine-3.12.0-released.html "Alpine v.3.12 on alpinelinux.org") - latest (state: 30.07.2020)

Current used dokuwiki version: [2020-07-29 "Hogfather"](https://download.dokuwiki.org/ "Download section on dokuwiki.org") - latest (state: 30.07.2020)


[ Written by @TimRabl ]( https://github.com/timrabl/ "@TimRabl GitHub")


## Preamble - what is dokuwiki ?
DokuWiki is a simple to use and highly versatile Open Source wiki software
that doesn't require a database. It is loved by users for its clean and
readable syntax. The ease of maintenance, backup and integration makes it an
administrator's favorite. Built in access controls and authentication
connectors make DokuWiki especially useful in the enterprise context and the
large number of plugins contributed by its vibrant community allow for a broad
range of use cases beyond a traditional wiki.

## make
For easier updating and deployment there is an `Makefile`.
This makefile supports the follwing task's:

#### get-latest
Pull the latest version from the provided path and writes it into the tmp/
directory and extract it into the *image-files/dokuwiki-latest/* folder.

#### build-latest (stable)
Build the latest docker image and Tag it with **latest**.
</br>
```sh
docker build \
	-t dokuwiki:latest \
	--build-arg VERSION=latest \
	image-files/
```

#### build-latest-installer
Build the latest docker image (including the install.php) and tag it with **latest-installer**.
</br>
```sh
docker build \
	-t dokuwiki:latest-installer \
	--build-arg VERSION=latest \
	--build-arg INSTALLER=true
	image-files/
```

#### build-latest-ldap
Build the latest docker image, tag it with **latest-ldap** and enables
the LDAP options in the conf/dokuwiki.php configuration.
</br>
```sh
docker build \
	-t dokuwiki:latest-ldap \
	--build-arg VERSION=latest \
	--build-arg LDAP=true \
	image-files/
```

#### build-latest-installer-ldap
Build the latest docker image, tag it with **latest-installer-ldap**,
including the install.php and enables LDAP options.
</br>
```sh
docker build \
	-t dokuwiki:latest-installer-ldap \
	--build-arg VERSION=latest \
	--build-arg INSTALLER=true \
	--build-arg LDAP=true \
	image-files/
```

## enviroment varibales
These are the main enviroment variables which can / must be passed to the docker image.
If you run the Image via `docker run` your can pass the environmen variables with:
`-e VAR_NAME=VAR_VALUE`

**Required vars are marked with an * at the end !**

| Variable | Explanation |
| -------- | ----------- |
| **openssl:** ||
| SSL_EXPIRE **\*** | The time period until the certificate becomes invalid |
| SSL_C | Country code (e.g. US, GB, DE, ...) |
| SSL_ST | State (e.g. London ) |
| SSL_L | Location (e.g. London ) |
| SSL_O | Organization (e.g. Example Organisation ) |
| SSL_OU | Organizational Unit (e.g. IT Department ) |
| SSL_CN **\*** | Common Name (e.g. example.com ) |
</br>

| Variable | Explanation |
| -------- | ----------- |
| **ldap:** ||
| LDAP_SERVER | The LDAP server url. (e.g. ldaps://ldap-server.example.org:123) |
| LDAP_USER_TREE | The user tree. (e.g. ou=users,dc=example,dc=org) |
| LDAP_GROUP_TREE | The group tree. (e.g. ou=groups,dc=example,dc=org) |
| LDAP_USER_FILTER | Userfilter for matching users. (e.g "(&(uid=%{user})(objectClass=posixAccount))") |
| LDAP_GROUP_FILTER | Groupfilter for matching groups. (e.g. "(&(objectClass=posixGroup)(memberUID=%{user}))") |
| LDAP_GRPS | Mapping can be used to specify where the internal data is coming from --> Mapping Where groups are defined in directory. |
| LDAP_BIND_DN | Optional bind DN if anonymous login if not allowed. (e.g "'cn=admin, dc=example, dc=org'") |
| LDAP_BIN_PW | Optional password for the above user. |
| LDAP_STARTTLS | This enables the use of the STARTTLS command (enable = 1 / disable = 0) |
| LDAP_VERSION | This is optional but may be required for your server (recommended: 3) |
</br>

## docker-compose
For easier use there is a docker-compose.yml file under the **compose-files/** folder.
This file contains all cofiguration for starting the dokuwiki and normally no extra configuration on this file is needed.
Please be sure to define all neccessary environment variables in the .env file.
There's a symlink called **environment** which points to the .env file ( maybe this makes it easier ).
Your 'll find all supported environment variables above in the **environment variables** section.
</br>
</br>
After you have set your environment variables correctly, you can start the compose stack using the following command:
```sh
docker-compose -f compose-files/docker-compose.yml up -d
```
Optionally there is also a "make" task which allows you to start / stop the compose stack.
These can be found in the make section.

## custom build hooks
In this repository there are custom build hooks, which allow you to modify the build process
in the docking hub or to pass build arguments. These can be found under `image-files/hooks/`.
