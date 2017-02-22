class nginx {
  File {
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
  Package {
    ensure => present,
  }
  Service {
    ensure     => running,
    enable     => true,
    hasrestart => true,
  }
  
  package { 'nginx': }
  
  file { '/var/www':
    ensure => directory,
  }
  file { '/var/www/index.html':
    source  => 'puppet:///modules/nginx/index.html',
  }
  
  file { '/etc/nginx':
    ensure => directory,
  }
  file { '/etc/nginx/nginx.conf':
    ensure  => file,
    source  => 'puppet:///modules/nginx/nginx.conf',
    notify  => Service['nginx'],
  }
  
  file { '/etc/nginx/conf.d':
    ensure => directory,
  }
  file { '/etc/nginx/conf.d/default.conf':
    source  => 'puppet:///modules/nginx/default.conf',
    notify  => Service['nginx'],
  }
  
  service { 'nginx': }
}
