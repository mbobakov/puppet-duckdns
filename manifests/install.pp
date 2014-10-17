# == Class duckdns::install
#
class duckdns::install {

  package { $duckdns::package_name:
    ensure => present,
  }
}
