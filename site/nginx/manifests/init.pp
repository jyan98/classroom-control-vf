class nginx{
  package { 'nginx':
    ensure => present,
  }
  service { 'nginx':
    ensure     => running,
    enable     => true,
    hasrestart => true,
  }
  
  file { '/etc/nginx/nginx.conf':
    ensure  => 'file',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    source  => 'puppet:///modules/nginx/nginx.conf',
    notify  => Service['nginx'],
  }
  file { '/etc/nginx/conf.d/default.conf':
    ensure  => 'file',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    source  => 'puppet:///modules/nginx/default.conf',
    notify  => Service['nginx'],
  }
  file { '/var/www/index.html':
    ensure  => 'file',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    source  => 'puppet:///modules/nginx/index.html',
  }
}
