# Change Log

## [2.0.1](https://github.com/dev-sec/linux-baseline/tree/2.0.1) (2016-12-21)
[Full Changelog](https://github.com/dev-sec/linux-baseline/compare/2.0.0...2.0.1)

**Closed issues:**

- permissions /etc/shadow [\#41](https://github.com/dev-sec/linux-baseline/issues/41)
- False positives in control os-06 [\#40](https://github.com/dev-sec/linux-baseline/issues/40)

**Merged pull requests:**

- update Gemfile [\#43](https://github.com/dev-sec/linux-baseline/pull/43) ([atomic111](https://github.com/atomic111))
- Update links in README file [\#42](https://github.com/dev-sec/linux-baseline/pull/42) ([netflash](https://github.com/netflash))
- Fix cpu flags and change default for net.ipv4.conf.all.log\_martians [\#39](https://github.com/dev-sec/linux-baseline/pull/39) ([chris-rock](https://github.com/chris-rock))

## [2.0.0](https://github.com/dev-sec/linux-baseline/tree/2.0.0) (2016-04-29)
[Full Changelog](https://github.com/dev-sec/linux-baseline/compare/1.3.0...2.0.0)

**Merged pull requests:**

- inspec profile [\#38](https://github.com/dev-sec/linux-baseline/pull/38) ([chris-rock](https://github.com/chris-rock))

## [1.3.0](https://github.com/dev-sec/linux-baseline/tree/1.3.0) (2016-04-25)
[Full Changelog](https://github.com/dev-sec/linux-baseline/compare/1.1.0...1.3.0)

**Fixed bugs:**

- update identifier [\#37](https://github.com/dev-sec/linux-baseline/pull/37) ([chris-rock](https://github.com/chris-rock))

**Merged pull requests:**

- prevent nil in flags [\#36](https://github.com/dev-sec/linux-baseline/pull/36) ([arlimus](https://github.com/arlimus))
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