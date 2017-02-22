class nginx {
  package { 'nginx':
    ensure => present,
  }
  
  file { '/var/www':
    ensure => 'directory',
    owner => 'nginx',
    group => 'nginx',
    mode => '0644',
    require => Package['nginx'],
  }
  
  file { '/var/www/index.html':
    ensure => file,
    owner => 'nginx',
    group => 'nginx',
    mode => '0644',
    source => "puppet:///modules/${module_name}/index.html",
    require => Package['nginx'],
  }
  
  file { '/etc/nginx/nginx.conf':
    ensure => file,
    owner => 'nginx',
    group => 'nginx',
    mode => '0644',
    require => Package['nginx'],
    content => file("${module_name}/nginx.conf"),
  }
  
  file { '/etc/nginx/conf.d/default.conf':
    ensure => file,
    owner => 'nginx',
    group => 'nginx',
    mode => '0644',
    content => file("${module_name}/default.conf"),
    require => Package['nginx'],
  }
  
  service {'nginx':
    ensure => running,
    enable => true,
    require => File['/etc/nginx/nginx.conf'],
  }
  
}
