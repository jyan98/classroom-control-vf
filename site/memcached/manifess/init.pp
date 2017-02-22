# $modulepath/memcached/manfests/init.pp
class memcached {
 package { 'memcached':
   ensure => present,
 }
 
 file { '/extc/sysconfig/memcached':
  ensure => file,
  owner => 'root',
  source => 'puppet:modules/memcached/memccached',
  require => Package['memcached'],
 }
