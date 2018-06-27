## `mkcryptpasswd` [![Build Status](https://travis-ci.org/essentialkaos/mkcryptpasswd.svg?branch=master)](https://travis-ci.org/essentialkaos/mkcryptpasswd) [![License](https://gh.kaos.st/ekol.svg)](https://essentialkaos.com/ekol)

`mcryptpasswd` is utility for hashing passwords to passwd compatible format (can be used for `/etc/shadow` file).

### Installation

#### From ESSENTIAL KAOS Public repo for RHEL6/CentOS6

```
[sudo] yum install -y https://yum.kaos.st/6/release/x86_64/kaos-repo-9.1-0.el6.noarch.rpm
[sudo] yum install mcryptpasswd
```

#### From ESSENTIAL KAOS Public repo for RHEL7/CentOS7

```
[sudo] yum install -y https://yum.kaos.st/7/release/x86_64/kaos-repo-9.1-0.el7.noarch.rpm
[sudo] yum install mcryptpasswd
```

#### Using `install.sh`

We provide simple bash script `script.sh` for installing app from the sources.

```
... install cracklib-check (RHEL/CentOS) or libpam-cracklib (Debian/Ubuntu)

git clone https://github.com/essentialkaos/mcryptpasswd.git
cd mcryptpasswd

[sudo] ./install.sh
```

If you have some issues with installing, try to use script in debug mode:

```
[sudo] ./install.sh --debug
```

### Usage

```
Usage: mkcryptpasswd {option}

Options

  --MD5, -1             Generate password hash by MD5 algorithm
  --SHA256, -5          Generate password hash by SHA algorithm with 256 bits digests
  --SHA512, -6          Generate password hash by SHA algorithm with 512 bits digests (default)
  --stdin, --           Read password from stdin
  --strong, -S          Return error if password is too weak
  --salt, -sa           Salt
  --salt-length, -sl    Generated salt length (4-16, 8 by default)
  --version, -v         Show information about version
  --help, -h            Show this help message

```

### Build Status

| Branch | Status |
|--------|--------|
| `master` | [![Build Status](https://travis-ci.org/essentialkaos/mkcryptpasswd.svg?branch=master)](https://travis-ci.org/essentialkaos/mkcryptpasswd) |
| `develop` | [![Build Status](https://travis-ci.org/essentialkaos/mkcryptpasswd.svg?branch=develop)](https://travis-ci.org/essentialkaos/mkcryptpasswd) |

### License

[EKOL](https://essentialkaos.com/ekol)

<p align="center"><a href="https://essentialkaos.com"><img src="https://gh.kaos.st/ekgh.svg"/></a></p>
