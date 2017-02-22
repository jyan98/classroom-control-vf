class memcached {
  package { 'memcached':
    ensure => present,
  }
  
  file { '/etc/sysconfig/memcached':
    ensure => present,
    source  => 'puppet:///modules/memcached/memcached',
    require => Package['memcached'],
    notify => Service['memcached'],
  }
  
  service { 'memcached':
    ensure => running,
    enable => true,
    require => File['/etc/sysconfig/memcached'],
  }
}
