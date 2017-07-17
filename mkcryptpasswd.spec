################################################################################

Summary:         Utility for encrypting passwords
Name:            mkcryptpasswd
Version:         1.7.0
Release:         0%{?dist}
License:         EKOL
Group:           Applications/System
URL:             https://github.com/essentialkaos/mkcryptpasswd
Vendor:          ESSENTIAL KAOS

Source0:         https://source.kaos.io/%{name}/%{name}-%{version}.tar.bz2

BuildArch:       noarch
BuildRoot:       %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

Requires:        python

Provides:        %{name} = %{version}-%{release}

###############################################################################

%description
Utility for generating encrypted passwords (can be used for /etc/shadow file)

###############################################################################

%prep
%setup -q

%build
%install
rm -rf %{buildroot}

install -dm 755 %{buildroot}%{_bindir}
install -dm 755 %{buildroot}%{_mandir}/man8

install -pm 755 %{name} %{buildroot}%{_bindir}/%{name}
install -pm 755 %{name}.8 %{buildroot}%{_mandir}/man8/

%clean
rm -rf %{buildroot}

%files
%defattr(-,root,root,-)
%doc LICENSE.EN LICENSE.RU
%{_bindir}/%{name}
%{_mandir}/man8/*.8*

###############################################################################

%changelog
* Tue Jul 18 2017 Anton Novojilov <andy@essentialkaos.com> - 1.7.0-0
- Fixed bug with options naming
- Short option for stdin set to -- (was -s)
- Added limit for errors (3)

* Mon Apr 24 2017 Anton Novojilov <andy@essentialkaos.com> - 1.6.3-0
- Arguments parser updated to v3 with fixed stderr output redirection for
  showArgWarn and showArgValWarn functions

* Thu Apr 06 2017 Anton Novojilov <andy@essentialkaos.com> - 1.6.2-0
- Output errors to stderr

* Wed Feb 15 2017 Anton Novojilov <andy@essentialkaos.com> - 1.6.1-0
- Improved version output

* Wed Nov 16 2016 Anton Novojilov <andy@essentialkaos.com> - 1.6.0-0
- Code refactoring
- Improved usage output

* Sat Jan 02 2016 Anton Novojilov <andy@essentialkaos.com> - 1.5.0-0
- Minor fixes and improvements 

* Mon Oct 19 2015 Anton Novojilov <andy@essentialkaos.com> - 1.4.1-0
- Minor fixes and improvements
- Updated man docs

* Sat Jan 03 2015 Anton Novojilov <andy@essentialkaos.com> - 1.4.0-0
- Removed shmin usage
- Improved argument parsing
- Refactoring

* Tue Aug 06 2013 Anton Novojilov <andy@essentialkaos.com> - 1.3.1-0
- Improved argument parsing
- Added shmin usage

* Fri Jun 14 2013 Anton Novojilov <andy@essentialkaos.com> - 1.3.0-0
- Fixed major bug with method args parsing
- Some minor improvements
- Short args suport
- Checking password strength
- Changed license to EKOL 

* Wed Oct 17 2012 Anton Novojilov <andy@essentialkaos.com> - 1.2.0-0
- Some improvements
- Small refactoring
- Salt and method number arguments

* Tue Sep 25 2012 Anton Novojilov <andy@essentialkaos.com> - 1.1.0-1
- Custom salt length
- Changed default salt length to 8 symbols

* Wed Jul 4 2012 Anton Novojilov <andy@essentialkaos.com> - 1.1.0-0
- Many improvements

* Thu May 24 2012 Anton Novojilov <andy@essentialkaos.com> - 1.0.0-0
- First version
