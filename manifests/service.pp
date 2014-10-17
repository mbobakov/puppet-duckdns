# == Class duckdns::service
#
# This class is meant to be called from duckdns
# It ensure the service is running
#
class duckdns::service {

  service { $duckdns::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
