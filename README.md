# docker-dokuwiki-alpine
Dokuwiki docker image inside a alpine image (v3.11) [Written by @TimRabl](https://github.com/timrabl/ "@TimRabl GitHub")
**Unencrypted traffic is not supported !**
  <br></br>


# Quickstart
For starting the Dokuwiki without Continuous Integration use:
```sh 
$ make update
$ make build
$ make deploy
```
Prerequisite are the following things:
- `curl`,  `make`,  `docker`,  `docker-compose` , `xmllint`, `wget`


# Continuous Integration

Prerequisite for this is a **.gitlab-ci.yml** file.  How to create a Continuous Integration file yourself and a few example files can be found here: [ GitLab Docs](https://docs.gitlab.com/ee/ci/docker/using_docker_build.html "Building Docker images with GitLab CI/CD")  

Gitlab will automatically run the file and deploy it on a configured GitLab Runner.  
How to set up a GitLab Runner can be found here: [GitLab Docs]( https://docs.gitlab.com/ee/ci/runners/ "Configuring GitLab Runners") 

#### With make:
	# If your infrastructure uses make,
	# you can easily add these lines to your build stage in your "CI / CD" file.
		
		# 'll pull the latest tarball from the official dokuwiki site and extract it to 
		# "image-files/dokuwiki" diectory automaticly;
		$ make update
		
		!!! IGNORE THIS STEP IF YOU'RE BUILDING FROM SCRATCH !!!
		# make sure to delete the install.php file from our dokuwiki path
		# since we already have existing instalations files 
		$ rm image-files/dokuwiki/install.php
	
		# build a docker image which is named as dokuwiki and tagged as latest - since we're using the	
		# latest tarball
		$ make build
	
	# the rest is done by the .gilab-ci.yml file 
	# The file contained in this repository is for demonstration purposes only, it has been specifically
	# adapted to this application case, so create your own with:	
		
		$ vim .gitlab-ci.yml
		
#### Without make:
	# If you aren't familiar with make or your infrastructure does not support it, you could add the
	# following lines to your build stage in your CI/CD file:
		
		# this make sure that there is no existing tmp/ folder
		$ [ ! -d "image-files/tmp/" ] && mkdir image-files/tmp/ || continue

		# this 'll get the latest stable dokuiki tarball from the offizial dokuwiki site
		$ curl https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz --output image-files/tmp/dokuwiki.tgz
		
		# create a folder where the tarball 'll be extracted into
		$ mkdir -p image-files/dokuwiki/
		
		# extract the dokuwiki.tgz 
		$ tar zxvf image-files/tmp/dokuwiki.tgz --strip-components=1 -C image-files/dokuwiki/

		# IGNORE THIS STEP IF YOU'RE BUILDING FROM SCRATCH
		# make sure to delete the install.php file from our dokuwiki path
		# since we already have existing instalations files 
		$ rm image-files/dokuwiki/install.php

		# remove the tmp/ dir 
		rm -r image-files/tmp/
	

# Docker Compose
This repository contains a sample **docker-compose.template** file for simply starting up on the target system.  
If you decide to use a compose file, please rename it to **.yml** and adjust the variables in this template   
if you want this system to be a secure, stable and productive system (you will find an explanation of each variable in the table below).

```yaml
...
  dokuwiki:
    ...
    environment:
      SERVER_NAME: ""
```
<br></br>

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

Brind the compose stack up with:
```sh
$ docker-compose up -d
```
Now navigate to https://{IP-ADRESS} ({:PORT})
