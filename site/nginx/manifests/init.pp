# $modulepath/site/nginx/manifests
class nginx {
  package {'nginx',
  ensure => present,
  }
 file {'/var/www' :
  ensure => directory,
  owner  => 'root',
  group  => 'root',
  mode  =>  '0755',
  }
  
file { '/var/www/index.html':
 ensure => file,
 owner => 'root',
 group => 'root',
 mode => '0664',
 source => 'puppet:///modules/nginx/index.html',
 }

 file {'/etc/nginx/ngxin.conf':
  ensure => file,
  owner => 'root',
  group => 'root'
  mode => '0644'
  source => 'puppet:///modules.nginx/nxgin.conf',
 }
 
 file {'/etc/nginx/conf.d':
  ensure=> directory,
  owner => 'root'
  group => 'root'
  mode  => '0775'
  source => 'puppet:///modules/nginx/default.conf',
  }
