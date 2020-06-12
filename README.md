<p align="center"><a href="#readme"><img src="https://gh.kaos.st/mcryptpasswd.svg"/></a></p>

<p align="center">
  <a href="https://travis-ci.com/essentialkaos/mcryptpasswd"><img src="https://travis-ci.com/essentialkaos/mcryptpasswd.svg"></a>
  <a href="https://essentialkaos.com/ekol"><img src="https://gh.kaos.st/ekol.svg"></a>
</p>

<p align="center"><a href="#installation">Installation</a> • <a href="#usage">Usage</a> • <a href="#build-status">Build Status</a> • <a href="#license">License</a></p>

<br/>

`mcryptpasswd` is utility for hashing passwords to passwd compatible format (can be used for `/etc/shadow` file).

### Installation

#### From ESSENTIAL KAOS Public repository

```bash
sudo yum install -y https://yum.kaos.st/get/$(uname -r).rpm
sudo yum install mcryptpasswd
```

#### From GitHub repository

```bash
curl -fL# -o mkcryptpasswd https://kaos.sh/mkcryptpasswd/SOURCES/mkcryptpasswd
chmod +x mkcryptpasswd
sudo mv mkcryptpasswd /usr/bin/
```

Also, you can use the latest version of utility without installation:

```bash
bash <(curl -fsSL https://kaos.sh/mkcryptpasswd/SOURCES/mkcryptpasswd) # pass options here
```

#### Using `install.sh`

We provide simple bash script `script.sh` for installing app from the sources.

```bash
# install cracklib-check (RHEL/CentOS) or libpam-cracklib (Debian/Ubuntu)

git clone https://github.com/essentialkaos/mcryptpasswd.git
cd mcryptpasswd

sudo ./install.sh
```

If you have some issues with installing, try to use script in debug mode:

```bash
sudo ./install.sh --debug
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
| `master` | [![Build Status](https://travis-ci.com/essentialkaos/mkcryptpasswd.svg?branch=master)](https://travis-ci.com/essentialkaos/mkcryptpasswd) |
| `develop` | [![Build Status](https://travis-ci.com/essentialkaos/mkcryptpasswd.svg?branch=develop)](https://travis-ci.com/essentialkaos/mkcryptpasswd) |

### License

[EKOL](https://essentialkaos.com/ekol)

<p align="center"><a href="https://essentialkaos.com"><img src="https://gh.kaos.st/ekgh.svg"/></a></p>
