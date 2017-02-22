class memcached {
  package { 'memcached':
    ensure => present,
  }
  service { 'memcached':
    ensure     => running,
    enable     => true,
    hasrestart => true,
  }
  
  file { '/etc/sysconfig/memcached':
    ensure  => 'file',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    source  => 'puppet:///modules/memcached/memcached',
    notify  => Service['memcached'],
    require => Package['memcached'],
  }
}
