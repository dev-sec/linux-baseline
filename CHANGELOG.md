# Change Log

## [2.3.0](https://github.com/dev-sec/linux-baseline/tree/2.3.0) (2019-05-14)
[Full Changelog](https://github.com/dev-sec/linux-baseline/compare/2.2.2...2.3.0)

**Closed issues:**

- Audit Daemon Fails on Amazon Linux 2 [\#109](https://github.com/dev-sec/linux-baseline/issues/109)
- os-11 fails on vanilla Ubuntu 16.04/18.04 [\#104](https://github.com/dev-sec/linux-baseline/issues/104)
- Container conditions to skip tests? [\#102](https://github.com/dev-sec/linux-baseline/issues/102)
- Duplicate testing for telnetd instead of rsh [\#97](https://github.com/dev-sec/linux-baseline/issues/97)
- Profile summary VS Test Summary  [\#93](https://github.com/dev-sec/linux-baseline/issues/93)
- Control Sysctl 31-b from sysctl\_spec.rb causing Inspec to exit with error code [\#92](https://github.com/dev-sec/linux-baseline/issues/92)

**Merged pull requests:**

- Add compatibility for alpine based images [\#111](https://github.com/dev-sec/linux-baseline/pull/111) ([zopanix](https://github.com/zopanix))
- Minor grammatical fix in README [\#108](https://github.com/dev-sec/linux-baseline/pull/108) ([cachedout](https://github.com/cachedout))
- Update issue templates [\#106](https://github.com/dev-sec/linux-baseline/pull/106) ([rndmh3ro](https://github.com/rndmh3ro))
- \#104 Fix os-11 for Ubuntu 16.04 and newer [\#105](https://github.com/dev-sec/linux-baseline/pull/105) ([IceBear2k](https://github.com/IceBear2k))
- efi-check should run on remote host, not locally [\#103](https://github.com/dev-sec/linux-baseline/pull/103) ([rndmh3ro](https://github.com/rndmh3ro))
- update grammar in desc [\#101](https://github.com/dev-sec/linux-baseline/pull/101) ([juliandunn](https://github.com/juliandunn))
- Update to test for rsh-server instead of duplicate telnetd [\#98](https://github.com/dev-sec/linux-baseline/pull/98) ([aavetis](https://github.com/aavetis))

## [2.2.2](https://github.com/dev-sec/linux-baseline/tree/2.2.2) (2018-07-19)
[Full Changelog](https://github.com/dev-sec/linux-baseline/compare/2.2.1...2.2.2)

**Merged pull requests:**

- Update to version 2.2.2 [\#99](https://github.com/dev-sec/linux-baseline/pull/99) ([james-stocks](https://github.com/james-stocks))
- Do not disable vfat by default [\#96](https://github.com/dev-sec/linux-baseline/pull/96) ([rndmh3ro](https://github.com/rndmh3ro))
- fix virtualization usage in older inspec versions [\#95](https://github.com/dev-sec/linux-baseline/pull/95) ([mattlqx](https://github.com/mattlqx))

## [2.2.1](https://github.com/dev-sec/linux-baseline/tree/2.2.1) (2018-05-14)
[Full Changelog](https://github.com/dev-sec/linux-baseline/compare/2.2.0...2.2.1)

**Closed issues:**

- /etc/shadow permissions false positive on Fedora [\#89](https://github.com/dev-sec/linux-baseline/issues/89)

**Merged pull requests:**

- Skip auditd and sysctl tests for containers [\#91](https://github.com/dev-sec/linux-baseline/pull/91) ([artem-sidorenko](https://github.com/artem-sidorenko))
- Fixes \#89 false positive /etc/shadow on Fedora [\#90](https://github.com/dev-sec/linux-baseline/pull/90) ([marcelhuth](https://github.com/marcelhuth))
- Fix typos in `inspec.yml` [\#88](https://github.com/dev-sec/linux-baseline/pull/88) ([jerryaldrichiii](https://github.com/jerryaldrichiii))

## [2.2.0](https://github.com/dev-sec/linux-baseline/tree/2.2.0) (2017-12-01)
[Full Changelog](https://github.com/dev-sec/linux-baseline/compare/2.1.1...2.2.0)

**Closed issues:**

- linux-baseline os-06 can not be skipped [\#86](https://github.com/dev-sec/linux-baseline/issues/86)
- control os-10 fails \(/etc/modprobe.d/dev-sec.conf\) [\#80](https://github.com/dev-sec/linux-baseline/issues/80)
- package-08 error on amazon linux [\#79](https://github.com/dev-sec/linux-baseline/issues/79)

**Merged pull requests:**

- deferring the execution of permissions to profile execution [\#87](https://github.com/dev-sec/linux-baseline/pull/87) ([chris-rock](https://github.com/chris-rock))
- CIS 4.1.1.3 [\#85](https://github.com/dev-sec/linux-baseline/pull/85) ([tomhaynes](https://github.com/tomhaynes))
- Update Fedora controls [\#84](https://github.com/dev-sec/linux-baseline/pull/84) ([shoekstra](https://github.com/shoekstra))
- Fix log\_dir\_group for Ubuntu 14.04+ [\#83](https://github.com/dev-sec/linux-baseline/pull/83) ([shoekstra](https://github.com/shoekstra))
- Tune some parameters for RedHat system [\#82](https://github.com/dev-sec/linux-baseline/pull/82) ([strangeman](https://github.com/strangeman))
- add logdir-check [\#81](https://github.com/dev-sec/linux-baseline/pull/81) ([rndmh3ro](https://github.com/rndmh3ro))
- Optimize file search routines [\#77](https://github.com/dev-sec/linux-baseline/pull/77) ([mcgege](https://github.com/mcgege))
- Check for Amazon Linux when determining audit package. [\#76](https://github.com/dev-sec/linux-baseline/pull/76) ([HenryTheHamster](https://github.com/HenryTheHamster))
- Update package\_spec.rb [\#74](https://github.com/dev-sec/linux-baseline/pull/74) ([lnxchk](https://github.com/lnxchk))
- CIS 1.5.4 Ensure prelink is disabled [\#73](https://github.com/dev-sec/linux-baseline/pull/73) ([bitvijays](https://github.com/bitvijays))
- Added net.ipv4.conf.default.log\_martians for Martian Packets in sysctl\_spec.rb [\#72](https://github.com/dev-sec/linux-baseline/pull/72) ([bitvijays](https://github.com/bitvijays))
- 1.1.1 CIS Disable unused filesystem [\#71](https://github.com/dev-sec/linux-baseline/pull/71) ([bitvijays](https://github.com/bitvijays))
- os-02: Fix for SUSE environments [\#70](https://github.com/dev-sec/linux-baseline/pull/70) ([mcgege](https://github.com/mcgege))
- On SUSE environments 'auditd' is part of package 'audit' [\#69](https://github.com/dev-sec/linux-baseline/pull/69) ([mcgege](https://github.com/mcgege))
- use recommended spdx license identifier [\#68](https://github.com/dev-sec/linux-baseline/pull/68) ([chris-rock](https://github.com/chris-rock))

## [2.1.1](https://github.com/dev-sec/linux-baseline/tree/2.1.1) (2017-06-02)
[Full Changelog](https://github.com/dev-sec/linux-baseline/compare/2.1.0...2.1.1)

**Closed issues:**

- systctl-33 doesn't see nx flag [\#65](https://github.com/dev-sec/linux-baseline/issues/65)
- check for audit\(d\) fails on aws linux ami [\#60](https://github.com/dev-sec/linux-baseline/issues/60)

**Merged pull requests:**

- CI: update to ruby 2.4.1 and rubocop 0.49.1 [\#66](https://github.com/dev-sec/linux-baseline/pull/66) ([artem-sidorenko](https://github.com/artem-sidorenko))
- Use assignment\_regex, only\_if and bump profile version [\#64](https://github.com/dev-sec/linux-baseline/pull/64) ([alexpop](https://github.com/alexpop))
- num\_logs has different values on different distros [\#63](https://github.com/dev-sec/linux-baseline/pull/63) ([artem-sidorenko](https://github.com/artem-sidorenko))
- Allow verification if kernel modules loading is disabled [\#62](https://github.com/dev-sec/linux-baseline/pull/62) ([artem-sidorenko](https://github.com/artem-sidorenko))
- Fix: more generic auditd settings [\#61](https://github.com/dev-sec/linux-baseline/pull/61) ([artem-sidorenko](https://github.com/artem-sidorenko))

## [2.1.0](https://github.com/dev-sec/linux-baseline/tree/2.1.0) (2017-05-08)
[Full Changelog](https://github.com/dev-sec/linux-baseline/compare/2.0.1...2.1.0)

**Merged pull requests:**

- update metadata [\#58](https://github.com/dev-sec/linux-baseline/pull/58) ([chris-rock](https://github.com/chris-rock))
- update gemfile [\#57](https://github.com/dev-sec/linux-baseline/pull/57) ([atomic111](https://github.com/atomic111))
- restrict ruby testing to version 2.3.3 [\#56](https://github.com/dev-sec/linux-baseline/pull/56) ([atomic111](https://github.com/atomic111))
- Properly verify the kernel dump setting [\#52](https://github.com/dev-sec/linux-baseline/pull/52) ([artem-sidorenko](https://github.com/artem-sidorenko))
- auditd package is called audit in the rhel family [\#51](https://github.com/dev-sec/linux-baseline/pull/51) ([rdeusser](https://github.com/rdeusser))
- Ignore inspec.lock file [\#50](https://github.com/dev-sec/linux-baseline/pull/50) ([techraf](https://github.com/techraf))
- Remove duplicated expectation from sysctl-16 [\#49](https://github.com/dev-sec/linux-baseline/pull/49) ([techraf](https://github.com/techraf))
- update links in readme [\#47](https://github.com/dev-sec/linux-baseline/pull/47) ([chris-rock](https://github.com/chris-rock))
- essay: differentiate redhat/debian, add extra conditions [\#44](https://github.com/dev-sec/linux-baseline/pull/44) ([juju4](https://github.com/juju4))

## [2.0.1](https://github.com/dev-sec/linux-baseline/tree/2.0.1) (2016-12-21)
[Full Changelog](https://github.com/dev-sec/linux-baseline/compare/2.0.0...2.0.1)

**Closed issues:**

- permissions /etc/shadow [\#41](https://github.com/dev-sec/linux-baseline/issues/41)
- False positives in control os-06 [\#40](https://github.com/dev-sec/linux-baseline/issues/40)

**Merged pull requests:**

- update profile metadata & tooling [\#46](https://github.com/dev-sec/linux-baseline/pull/46) ([chris-rock](https://github.com/chris-rock))
- update Gemfile [\#43](https://github.com/dev-sec/linux-baseline/pull/43) ([atomic111](https://github.com/atomic111))
- Update links in README file [\#42](https://github.com/dev-sec/linux-baseline/pull/42) ([netflash](https://github.com/netflash))
- Fix cpu flags and change default for net.ipv4.conf.all.log\_martians [\#39](https://github.com/dev-sec/linux-baseline/pull/39) ([chris-rock](https://github.com/chris-rock))

## [2.0.0](https://github.com/dev-sec/linux-baseline/tree/2.0.0) (2016-04-29)
[Full Changelog](https://github.com/dev-sec/linux-baseline/compare/1.3.0...2.0.0)

**Merged pull requests:**

- inspec profile [\#38](https://github.com/dev-sec/linux-baseline/pull/38) ([chris-rock](https://github.com/chris-rock))

## [1.3.0](https://github.com/dev-sec/linux-baseline/tree/1.3.0) (2016-04-25)
[Full Changelog](https://github.com/dev-sec/linux-baseline/compare/1.2.0...1.3.0)

**Fixed bugs:**

- update identifier [\#37](https://github.com/dev-sec/linux-baseline/pull/37) ([chris-rock](https://github.com/chris-rock))

**Merged pull requests:**

- prevent nil in flags [\#36](https://github.com/dev-sec/linux-baseline/pull/36) ([arlimus](https://github.com/arlimus))

## [1.2.0](https://github.com/dev-sec/linux-baseline/tree/1.2.0) (2015-12-08)
[Full Changelog](https://github.com/dev-sec/linux-baseline/compare/1.1.0...1.2.0)

**Merged pull requests:**

- removed serverspec support and created all inspec tests [\#35](https://github.com/dev-sec/linux-baseline/pull/35) ([atomic111](https://github.com/atomic111))

## [1.1.0](https://github.com/dev-sec/linux-baseline/tree/1.1.0) (2015-10-15)
[Full Changelog](https://github.com/dev-sec/linux-baseline/compare/1.0.0...1.1.0)

**Merged pull requests:**

- Remove whitespace [\#34](https://github.com/dev-sec/linux-baseline/pull/34) ([rndmh3ro](https://github.com/rndmh3ro))
- Improve Ansible tests [\#33](https://github.com/dev-sec/linux-baseline/pull/33) ([rndmh3ro](https://github.com/rndmh3ro))
- Fix typos [\#31](https://github.com/dev-sec/linux-baseline/pull/31) ([rndmh3ro](https://github.com/rndmh3ro))
- update urls [\#30](https://github.com/dev-sec/linux-baseline/pull/30) ([chris-rock](https://github.com/chris-rock))
- bugfix: add missing: ipv6 accept\_ra = 0 [\#29](https://github.com/dev-sec/linux-baseline/pull/29) ([arlimus](https://github.com/arlimus))
- Ansible support [\#28](https://github.com/dev-sec/linux-baseline/pull/28) ([rndmh3ro](https://github.com/rndmh3ro))
- add json format option [\#26](https://github.com/dev-sec/linux-baseline/pull/26) ([atomic111](https://github.com/atomic111))
- Update common [\#25](https://github.com/dev-sec/linux-baseline/pull/25) ([arlimus](https://github.com/arlimus))
- feature: add schroot to suid/sgid whitelist [\#24](https://github.com/dev-sec/linux-baseline/pull/24) ([arlimus](https://github.com/arlimus))
- Update common [\#23](https://github.com/dev-sec/linux-baseline/pull/23) ([arlimus](https://github.com/arlimus))
- updating common files [\#22](https://github.com/dev-sec/linux-baseline/pull/22) ([arlimus](https://github.com/arlimus))
- changed GIS to DTAG SEC [\#21](https://github.com/dev-sec/linux-baseline/pull/21) ([atomic111](https://github.com/atomic111))
- bugfix: lint error [\#20](https://github.com/dev-sec/linux-baseline/pull/20) ([chris-rock](https://github.com/chris-rock))

## [1.0.0](https://github.com/dev-sec/linux-baseline/tree/1.0.0) (2014-08-13)
**Merged pull requests:**

- Lockdown mode [\#19](https://github.com/dev-sec/linux-baseline/pull/19) ([arlimus](https://github.com/arlimus))
- split sysctl\_spec.rb, added suid whitliste and uid unique search [\#18](https://github.com/dev-sec/linux-baseline/pull/18) ([atomic111](https://github.com/atomic111))
- added additional test [\#17](https://github.com/dev-sec/linux-baseline/pull/17) ([atomic111](https://github.com/atomic111))
- add travis config, add default task to rakefile [\#16](https://github.com/dev-sec/linux-baseline/pull/16) ([ehaselwanter](https://github.com/ehaselwanter))
- update rubocop, add common linter task, fix rubocop issues [\#15](https://github.com/dev-sec/linux-baseline/pull/15) ([ehaselwanter](https://github.com/ehaselwanter))
- fix exec-shield test [\#14](https://github.com/dev-sec/linux-baseline/pull/14) ([chris-rock](https://github.com/chris-rock))
- add lint rake task with robocop and fix issues [\#13](https://github.com/dev-sec/linux-baseline/pull/13) ([chris-rock](https://github.com/chris-rock))
- added Telekom Security Requirement numbers to the corresponding kitchen test [\#12](https://github.com/dev-sec/linux-baseline/pull/12) ([atomic111](https://github.com/atomic111))
- add ruby gem source [\#11](https://github.com/dev-sec/linux-baseline/pull/11) ([chris-rock](https://github.com/chris-rock))
- add standalone usage feature [\#10](https://github.com/dev-sec/linux-baseline/pull/10) ([ehaselwanter](https://github.com/ehaselwanter))
- serverspec has a contract on running commands remote. this fixes the local [\#9](https://github.com/dev-sec/linux-baseline/pull/9) ([ehaselwanter](https://github.com/ehaselwanter))
- add lockfiles and delete them from tree [\#8](https://github.com/dev-sec/linux-baseline/pull/8) ([ehaselwanter](https://github.com/ehaselwanter))
- rubocop fixes [\#7](https://github.com/dev-sec/linux-baseline/pull/7) ([ehaselwanter](https://github.com/ehaselwanter))
- moved site.pp to the shared test, were it belongs [\#6](https://github.com/dev-sec/linux-baseline/pull/6) ([ehaselwanter](https://github.com/ehaselwanter))
- bugfix: arp restrictions should apply to all, not just eth0 [\#5](https://github.com/dev-sec/linux-baseline/pull/5) ([arlimus](https://github.com/arlimus))
- one folder level up [\#4](https://github.com/dev-sec/linux-baseline/pull/4) ([ehaselwanter](https://github.com/ehaselwanter))
- Fix: change value of log\_martians to the cookbook default [\#3](https://github.com/dev-sec/linux-baseline/pull/3) ([atomic111](https://github.com/atomic111))
- discard one level to be able to use the defaults in test-kitchen by just [\#2](https://github.com/dev-sec/linux-baseline/pull/2) ([ehaselwanter](https://github.com/ehaselwanter))
- added tests from chef-os-hardening [\#1](https://github.com/dev-sec/linux-baseline/pull/1) ([ehaselwanter](https://github.com/ehaselwanter))



\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*