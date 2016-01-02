### mcryptpasswd

`mcryptpasswd` is utility for encrypting passwd compatible passwords (can be used for /etc/shadow file).

#### Installation

###### From ESSENTIAL KAOS Public repo for RHEL6/CentOS6

```
yum install -y http://release.yum.kaos.io/i386/kaos-repo-6.8-0.el6.noarch.rpm
yum install mcryptpasswd
```

###### Using install.sh

We provide simple bash script `script.sh` for installing app from the sources.

```
... install cracklib-check

git clone https://github.com/essentialkaos/mcryptpasswd.git
cd mcryptpasswd

sudo ./install.sh
```

If you have some issues with installing, try to use script in debug mode:

```
sudo ./install.sh --debug
```

#### Usage

```
Usage: mkcryptpasswd <option>
 
Options: 
  --MD5, -1                 Generate password hash by MD5 algorithm
  --SHA256, -5              Generate password hash by SHA algorithm with 256 bits digests
  --SHA512, -6              Generate password hash by SHA algorithm with 512 bits digests (default)
  --stdin, -s               Read password from stdin
  --strong, -S              Return error if password is too weak
  --salt, -sa               Salt
  --salt-length, -sl        Generated salt length (4-16, 8 by default)
  --version, --ver, -v      Show information about version
  --help, --usage, -h       Show this help message

```

#### Build Status

| Repository | Status |
|------------|--------|
| Stable | [![Build Status](https://travis-ci.org/essentialkaos/mkcryptpasswd.svg?branch=master)](https://travis-ci.org/essentialkaos/mkcryptpasswd) |
| Unstable | [![Build Status](https://travis-ci.org/essentialkaos/mkcryptpasswd.svg?branch=develop)](https://travis-ci.org/essentialkaos/mkcryptpasswd) |

#### License

[EKOL](https://essentialkaos.com/ekol)
