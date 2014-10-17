# == Class: duckdns
#
# Full description of class duckdns here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class duckdns (
  $package_name = $duckdns::params::package_name,
  $service_name = $duckdns::params::service_name,
) inherits duckdns::params {

  # validate parameters here

  class { 'duckdns::install': } ->
  class { 'duckdns::config': } ~>
  class { 'duckdns::service': } ->
  Class['duckdns']
}
