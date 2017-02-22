class nginx {
  package { 'nginx':
    ensure => present,
  }
  
  file { '/var/www':
    ensure => 'directory',
    owner => 'nginx',
    group => 'nginx',
    mode => '0644',
  }
  
  file { '/var/www/index.html':
    ensure => file,
    owner => 'nginx',
    group => 'nginx',
    mode => '0644',
    source => 'puppet:///modules/${module}/index.html',
  }
  
  file { '/etc/nginx/nginx.conf':
    ensure => file,
    owner => 'nginx',
    group => 'nginx',
    mode => '0644',
    require => Package['nginx'],
    source => 'puppet:///modules/${module}/nginx.conf',
  }
  
  file { '/etc/nginx/conf.d/default.conf':
    ensure => file,
    owner => 'nginx',
    group => 'nginx',
    mode => '0644',
    source => 'puppet:///modules/${module}/default.conf',
  }
  
  service {'nginx':
    ensure => running,
    enable => true,
    require => File['/etc/nginx/nginx.conf'],
  }
  
}
