# init.pp file for demo

class nginx {

  File {
    ensure => 'file',
    owner => 'root',
    group => 'root',
    mode => '0644',
  }
  package { 'nginx':
   ensure => 'installed',
  }
  
  service { 'nginx':
    ensure => 'running',
    enable => 'true',
    subscribe => File['/etc/nginx/nginx.conf','/etc/nginx/conf.d/default.conf'],
}
file { ['/var/www','/etc/nginx']:
  ensure => 'directory',
}

file { '/etc/nginx/conf.d/default.conf':
  source  => 'puppet:///modules/nginx/default.conf',
  require => Package['nginx'],
}
file { '/etc/nginx/nginx.conf':
  require => Package['nginx'],
  source  => 'puppet:///modules/nginx/nginx.conf',
 } 
 file { '/var/www/index.html':
  source  => 'puppet:///modules/nginx/index.html',
 } 
}
