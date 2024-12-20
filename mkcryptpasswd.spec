################################################################################

Summary:    Utility for hashing password
Name:       mkcryptpasswd
Version:    1.9.4
Release:    0%{?dist}
License:    Apache License, Version 2.0
Group:      Applications/System
URL:        https://kaos.sh/mkcryptpasswd
Vendor:     ESSENTIAL KAOS

Source0:    https://source.kaos.st/%{name}/%{name}-%{version}.tar.bz2

BuildArch:  noarch
BuildRoot:  %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

Requires:   bash python

Provides:   %{name} = %{version}-%{release}

################################################################################

%description
Utility for generating encrypted passwords (can be used for /etc/shadow file).

################################################################################

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

################################################################################

%files
%defattr(-,root,root,-)
%doc LICENSE
%{_bindir}/%{name}
%{_mandir}/man8/*.8*

################################################################################

%changelog
* Fri Dec 06 2024 Anton Novojilov <andy@essentialkaos.com> - 1.9.4-0
- Improved options parsing

* Tue Jun 11 2024 Anton Novojilov <andy@essentialkaos.com> - 1.9.3-0
- Improved automatic disabling of color output usage

* Thu Nov 30 2023 Anton Novojilov <andy@essentialkaos.com> - 1.9.2-0
- Code refactoring

* Sat Feb 04 2023 Anton Novojilov <andy@essentialkaos.com> - 1.9.1-0
- Code refactoring

* Sat Apr 03 2021 Anton Novojilov <andy@essentialkaos.com> - 1.9.0-0
- Added Python 3 support
- Updated options parser to the latest version
- Code refactoring
- Minor improvements

* Sat Sep 26 2020 Anton Novojilov <andy@essentialkaos.com> - 1.8.0-0
- Added option --secure/-s for disabling echoing password

* Wed Dec 04 2019 Anton Novojilov <andy@essentialkaos.com> - 1.7.3-0
- Removed handler for script errors

* Sat Nov 30 2019 Anton Novojilov <andy@essentialkaos.com> - 1.7.2-0
- Added handling of SCRIPT_DEBUG environment variable for enabling debug mode
- Added handler for script errors

* Tue Dec 12 2017 Anton Novojilov <andy@essentialkaos.com> - 1.7.1-0
- Code refactoring

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
- Short args support
- Checking password strength
- Changed license to Apache License, Version 2.0

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
