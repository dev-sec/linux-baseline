tests-os-hardening
==================

This are the integration tests for the projects

- https://github.com/hardening-io/puppet-os-hardening
- https://github.com/hardening-io/chef-os-hardening
- https://github.com/hardening-io/ansible-os-hardening
 
They start at `integration` level.

you can use the gem `kitchen-sharedtests`

- https://github.com/ehaselwanter/kitchen-sharedtests/

to make them available to your project. Use `thor kitchen:fetch-remote-tests` to put the repo into `test/integration`.  

## Standalone Usage

You can target the integration tests to any host where you have ssh access.

`rake -T` gives you a list of suites you can run (we'll ignore directories which are obviously not suites for now)

```
± rake -T
rake serverspec:data_bags  # Run serverspec suite data_bags
rake serverspec:default    # Run serverspec suite default
```

Run it with:

```
bundle install

# default user and ssh-key

bundle exec rake serverspec:default target_host=<name-or-ip-of-target-server>

# or with user, host, password

ASK_LOGIN_PASSWORD=true bundle exec rake serverspec:default target_host=192.168.1.222 user=stack
```

Add `format=html|json` to get a report.html or report.json document.

