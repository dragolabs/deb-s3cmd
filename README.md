# deb-s3cmd
[![Build Status](https://travis-ci.org/dragolabs/deb-s3cmd.svg?branch=master)](https://travis-ci.org/dragolabs/deb-s3cmd)

### Depends
You need ruby and fpm gem for create .deb package.

### Usage
You can use build.sh with Jenkins or in your terminal. Set env vars VENDOR and MAINTAINER to sign created package. Also you can specify version of s3cmd as first parameter for script .


```bash
$ ./build.sh -m 'John Smith' -o 'my_org' -v 1.5.1.2

[... many symbols ...]

Created package {:path=>"s3cmd-1.5.1.2-my_org1502052003-amd64.deb"}

```
