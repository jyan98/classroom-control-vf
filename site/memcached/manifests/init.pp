class memcached {
  package { 'memcached':
    ensure => present,
  }
  file { '/etc/sysconfig/memcached':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '644',
    source => "puppet:///modules/${module_name}/memcached",
    require => Package['memcached'],
  }
  service { 'memcached':
    ensure => running,
    enable => true,
    subscribe => File['/etc/sysconfig/memcached'],
  }
}
