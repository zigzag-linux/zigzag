Name:           zigzag-configuration
Version:        0
Release:        0
Summary:        Configuration of Zigzag Linux
License:        GPL-3.0
Group:          System/Base
Url:            https://github.com/zigzag-linux/zigzag-configuration
Source0:        %{name}-%{version}.tar
BuildArch:      noarch

BuildRequires:  make
BuildRequires:  ansible
Requires:       ansible

%description
Configuration files (Ansible Playbooks) preserving default configuration of Zigzag Linux images.

%prep
%autosetup

%install
make install DESTDIR=%{buildroot}

%check
make check DESTDIR=%{buildroot}

%files
%doc README.md LICENSE
%dir %{_datadir}/zigzag
%dir %{_datadir}/zigzag/ansible
%{_datadir}/zigzag/ansible/*
%{_bindir}/zigzag-write-configuration
