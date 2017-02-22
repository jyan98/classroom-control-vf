# init.pp file for demo

class nginx {
  package { 'nginx':
   ensure => 'installed',
  }
  service { 'nginx':
    ensure => 'running',
    enable => 'true',
}
file { '/var/www':
  ensure => 'directory',
}
file { '/etc/nginx':
  ensure => 'directory',
}

file { '/etc/nginx/conf.d/default.conf':
  ensure => 'file',
  owner => 'root',
  group => 'root',
  mode => '0644',
  source  => 'puppet:///modules/nginx/default.conf',
}
file { '/etc/nginx/nginx.conf':
  ensure => 'file',
  owner => 'root',
  group => 'root',
  mode => '0644',
  source  => 'puppet:///modules/nginx/nginx.conf',
 } 
 file { '/var/www/index.html':
  ensure => 'file',
  owner => 'root',
  group => 'root',
  mode => '0644',
  source  => 'puppet:///modules/nginx/index.html',
 } 
}
