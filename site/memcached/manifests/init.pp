# $modulepath/memcached/manifests/init.pp
class memcached {
  package { 'memcached':
    ensure => 'present',
  }
  file { '/etc/sysconfig/memcached':
    ensure => 'present',
    source => 'puppet:///memcached/files/memcached',
    require => Package['memcached'],
    notify => Service['memcached'],
  }
  service { 'memcached':
    ensure => 'started',
    enable => 'true',
  }
}
