# $modulepath/nginx/manifests/init.pp

  
class nginx {
  File {
  ensure => 'file',
  group => 'root',
  owner => 'root',
  mode  => '0644',
  }
  
  package { 'nginx': 
    ensure => 'present',
    }
  
  file { '/var/www':
    ensure => 'directory',
    }
  file { '/etc/nginx/nginx.conf':
    source => 'puppet:///modules/nginx/nginx.conf',
    }
  file { '/etc/nginx/conf.d/default.conf':
    source => 'puppet:///modules/nginx/default.conf',
    }
  file { '/var/www/index.html':
    source => 'puppet:///modules/nginx/index.html',
    }
  service { 'nginx':
    ensure => 'running',
    }
}
  
