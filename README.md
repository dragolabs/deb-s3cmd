# deb-s3cmd
[![Build Status](https://travis-ci.org/dragolabs/deb-s3cmd.svg?branch=master)](https://travis-ci.org/dragolabs/deb-s3cmd)

## Depends
You need ruby and fpm installed to create .deb package.


## Options build.sh
* `-m` - optional. Set the maintainer's name, mail, etc. Default: user@hostname
* `-v` - optional. version of s3cmd. Default: 1.5.1.2
* `-o` - optional. Used to set org in the iteration of the package (example: wheezy1, myorg2, etc). Default: debian


## Usage
Use build.sh with Jenkins or in your terminal.  
You'll find your .deb in the _pkg directory.

```bash
$ ./build.sh -m 'John Smith' -o 'my_org' -v 1.5.1.2

[... many symbols ...]

Created package {:path=>"s3cmd-1.5.1.2-my_org1502052003-amd64.deb"}

```

## Links
* [s3cmd](http://s3tools.org/s3cmd)
* [FPM](https://github.com/jordansissel/fpm)