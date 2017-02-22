class nginx{
  $nginxdirs=['/var/www','/etc/nginx','/etc/nginx/conf.d']
  
  File {
    ensure  => 'file',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }
  
  package { 'nginx':
    ensure => present,
  }
  service { 'nginx':
    ensure     => running,
    enable     => true,
    hasrestart => true,
  }
  
  file { $nginxdirs:
    ensure => 'directory',
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }
  
  file { '/etc/nginx/nginx.conf':
    source  => 'puppet:///modules/nginx/nginx.conf',
    notify  => Service['nginx'],
    require => Package['nginx'],
  }
  file { '/etc/nginx/conf.d/default.conf':
    source  => 'puppet:///modules/nginx/default.conf',
    notify  => Service['nginx'],
    require => Package['nginx'],
  }
  file { '/var/www/index.html':
    source  => 'puppet:///modules/nginx/index.html',
  }
}
