##Module Description
Client for DuckDNS dynamic dns service (https://duckdns.org/). Create cron job for update ip's and put logs about update process into systemjournal. Now only UNIX-like OS is supported. Pull-requests are welcome. ;)  

##Setup
puppet module install revglor-duckdns

##Params
####`ensure`
   Ensure for this client. Mandatory. String. Default: `present`
####`token`
   Usertoken for DuckDNS account. Mandatory. String. Default: `empty`
####`ip`
   Static ip for each domain in domains-array. If empty, use current public ip. Optional. String. Default: `empty`
####`update_minutes`
   How often update ip in minutes. Uses for create cron job. Mandatory. Int. Default: `5`
####`updater`
   Location of the updater-script. Default: `/opt/duckdns.sh`
####`domains`
   Domains for update. Mandatory. Array. Default: empty

##Sample Usage
###Puppet class
   ```puppet
    class { 'duckdns':
      ensure         => 'present',
      token          => 'token_fer43sdgf245tswdfg34sdfgsdf',
      ip             => '8.8.8.8',
      update_minutes => 15,
      updater        => '/opt/duckdns.sh',
      domains        => ['test', 'tst.example'],
    } 
   ```
####With Hiera 
  
  ``include duckdns`` in manifest and 
    add Hiera params: 
    
    
    duckdns::ensure: 'present'
    duckdns::token: 'token_fer43sdgf245tswdfg34sdfgsdf'
    duckdns::ip: '8.8.8.8' 
    duckdns::update_minutes: 15
    duckdns::updater: '/opt/duckdns.sh'
    duckdns::domains: ['test', 'tst.example']``
  
>### About params see [Params](# Params)

##Development

Patches are welcome. realy
