# $modulepath/nginx/manifests/init.pp

class nginx {
  package { 'nginx': 
    ensure => 'present',
    }
  file { '/var/www':
    ensure => 'directory',
    }
  file { '/etc/nginx/nginx.conf':
    ensure => 'file',
    group => 'root',
    owner => 'root',
    mode => '0664',
    source => 'puppet:///modules/nginx/nginx.conf',
    }
  file { '/etc/nginx/conf.d/default.conf':
    ensure => 'file',
    group => 'root',
    owner => 'root',
    mode => '0664',
    source => 'puppet:///modules/nginx/default.conf',
    }
  file { '/var/www/index.html':
    ensure => 'file',
    group => 'root',
    owner => 'root',
    mode => '0664',
    source => 'puppet:///modules/nginx/index.html',
    }
}
  
