## `mkcryptpasswd` [![Build Status](https://travis-ci.org/essentialkaos/mkcryptpasswd.svg?branch=master)](https://travis-ci.org/essentialkaos/mkcryptpasswd) [![Code Climate](https://codeclimate.com/github/essentialkaos/mkcryptpasswd/badges/gpa.svg)](https://codeclimate.com/github/essentialkaos/mkcryptpasswd) [![License](https://gh.kaos.io/ekol.svg)](https://essentialkaos.com/ekol)

`mcryptpasswd` is utility for encrypting passwd compatible passwords (can be used for `/etc/shadow` file).

### Installation

#### From ESSENTIAL KAOS Public repo for RHEL6/CentOS6

```
[sudo] yum install -y https://yum.kaos.io/6/release/x86_64/kaos-repo-8.0-0.el6.noarch.rpm
[sudo] yum install mcryptpasswd
```

#### From ESSENTIAL KAOS Public repo for RHEL7/CentOS7

```
[sudo] yum install -y https://yum.kaos.io/7/release/x86_64/kaos-repo-8.0-0.el7.noarch.rpm
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
  --stdin, -s           Read password from stdin
  --strong, -S          Return error if password is too weak
  --salt, -sa           Salt
  --salt-length, -sl    Generated salt length (4-16, 8 by default)
  --version, -v         Show information about version
  --help, -h            Show this help message

```

### Build Status

| Branch | Status |
|------------|--------|
| `master` | [![Build Status](https://travis-ci.org/essentialkaos/mkcryptpasswd.svg?branch=master)](https://travis-ci.org/essentialkaos/mkcryptpasswd) |
| `develop` | [![Build Status](https://travis-ci.org/essentialkaos/mkcryptpasswd.svg?branch=develop)](https://travis-ci.org/essentialkaos/mkcryptpasswd) |

### License

[EKOL](https://essentialkaos.com/ekol)
