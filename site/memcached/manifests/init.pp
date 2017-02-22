class memcached {
  package { 'memcached':
    ensure => present,
  }
  file { '/etc/sysconfig/memcached':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/memcached/etc_sysconfig_memcached',
    notify  => Service['memcached'],
    require => Package['memcached'],
  }
  service { 'memcached':
    ensure     => running,
    enable     => true,
    hasrestart => true,
  }
}
