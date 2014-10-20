# == Class: duckdns
#
# Main class for duckdns client. Create shell script from template and add cron job.
# Saple usage
#   class { 'duckdns':
#            ensure         => 'present',
#            token          => 'adfasfer43sdgf245tswdfg34sdfgsdf',
#            ip             => '8.8.8.8',
#            update_minutes => 15,
#            updater        => '/opt/duckdns.sh',
#            domains        => ['test', 'tst.example'],
#   }

# === Parameters
#
# [*ensure*]
#   Ensure for this client. Mandatory. String. Default: present
# [*token*]
#   Usertoken for DuckDNS account. Mandatory. String. Default: empty
# [*ip*]
#   Static ip for each domain in domains-array. If empty, use current public ip. Optional. String. Default: empty
# [*update_minutes*]
#   How often update ip in minutes. Uses for create cron job. Mandatory. Int. Default: 5
# [*updater*]
#   Location of the updater-script. Default: /opt/duckdns.sh
# [*domains*]
#   Domains for update. Mandatory. Array. Default: empty

class duckdns (
  $ensure         = 'present',
  $token          = undef,
  $ip             = undef,
  $update_minutes = 15,
  $updater        = '/opt/duckdns.sh',
  $domains        = undef
) {
  # validate parameters. TODO: replace tis thing in Puppet 4.0 parser
  validate_re($ensure, ['present','absent'])
  validate_string($token)
  if $ip { validate_re($ip , '((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)') }
  $update_minutes_str = "${update_minutes}"
  validate_re($update_minutes_str, '[1-5][0-9]{0,1}$' )
  validate_absolute_path($updater)
  #Validate environment.
  #TODO: add Validate environment.
  # end of validate block
  $directory = dirname($updater)
  file { $directory:
    ensure => directory,
    before => File[$updater],
  }
  file { $updater:
    ensure  => $ensure,
    mode    => '0755',
    content => template('duckdns/duckdns.sh.erb'),
  }
  cron { 'duckdns_updater':
    command  => "${updater} >/dev/null 2>&1",
    user     => 'root',
    month    => '*',
    monthday => '*',
    hour     => '*',
    minute   => "*/${update_minutes}",
  }
}
