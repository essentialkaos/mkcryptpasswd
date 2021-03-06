<p align="center"><a href="#readme"><img src="https://gh.kaos.st/mkcryptpasswd.svg"/></a></p>

<p align="center">
  <a href="https://github.com/essentialkaos/mkcryptpasswd/actions"><img src="https://github.com/essentialkaos/mkcryptpasswd/workflows/CI/badge.svg" alt="GitHub Actions Status" /></a>
  <a href="#license"><img src="https://gh.kaos.st/apache2.svg"></a>
</p>

<p align="center"><a href="#installation">Installation</a> • <a href="#usage">Usage</a> • <a href="#build-status">Build Status</a> • <a href="#license">License</a></p>

<br/>

`mkcryptpasswd` is utility for hashing passwords.

### Installation

#### From [ESSENTIAL KAOS Public Repository](https://yum.kaos.st)

```bash
sudo yum install -y https://yum.kaos.st/get/$(uname -r).rpm
sudo yum install mkcryptpasswd
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

We provide simple bash script `install.sh` for installing app from the sources.

```bash
# install python and cracklib-check (RHEL/CentOS) or libpam-cracklib (Debian/Ubuntu)

git clone https://kaos.sh/mkcryptpasswd.git
cd mkcryptpasswd

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
  --secure, -s          Do not echo password
  --salt, -sa           Salt
  --salt-length, -sl    Generated salt length (4-16, 8 by default)
  --version, -v         Show information about version
  --help, -h            Show this help message

```

### Build Status

| Branch | Status |
|--------|--------|
| `master` | [![CI](https://github.com/essentialkaos/mkcryptpasswd/workflows/CI/badge.svg?branch=master)](https://github.com/essentialkaos/mkcryptpasswd/actions) |
| `develop` | [![CI](https://github.com/essentialkaos/mkcryptpasswd/workflows/CI/badge.svg?branch=develop)](https://github.com/essentialkaos/mkcryptpasswd/actions) |

### License

[Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0)

<p align="center"><a href="https://essentialkaos.com"><img src="https://gh.kaos.st/ekgh.svg"/></a></p>
