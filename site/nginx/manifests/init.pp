# stealiong Lauras code since I cant write puppet code

# $modulepath/nginx/manifests/init.pp
class nginx {
  File {
    ensure => file,
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  package { 'nginx':
    ensure => present,
  }
  
  file { '/var/www':
    ensure => directory,
  }
  
  file { '/var/www/index.html':
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file { '/etc/nginx/nginx.conf':
    source => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
  }

  file { '/etc/nginx/conf.d/default.conf':
    source => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'],
  }
  
  service { 'nginx':
    ensure    => running,
    subscribe => [File['/etc/nginx/nginx.conf'],File['/etc/nginx/conf.d/default.conf']],
  }
}
