# == Class duckdns::params
#
# This class is meant to be called from duckdns
# It sets variables according to platform
#
class duckdns::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'duckdns'
      $service_name = 'duckdns'
    }
    'RedHat', 'Amazon': {
      $package_name = 'duckdns'
      $service_name = 'duckdns'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
