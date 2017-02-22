# $modulepath/nginx/manifests/init.pp

  
class nginx {

  case $facts['os']['name']{
    'redhat','centos': {
      $package = 'nginx'
      $owner = 'root'
      $group = 'root'
      $docroot = '/var/www/'
      $configdir = '/etc/nginx/'
      $logdir = '/var/log/nginx'
      $servicename = 'nginx'
      $nginxuser = 'nginx'
    }
    'debian','ubuntu': {
      $package = 'nginx'
      $owner = 'root'
      $group = 'root'
      $docroot = '/var/www/'
      $configdir = '/etc/nginx/'
      $logdir = '/var/log/nginx'
      $servicename = 'nginx'
      $nginxuser = 'nginx'
    }
    'windows': {
      $package = 'nginx'
      $owner = 'root'
      $group = 'root'
      $docroot = '/var/www/'
      $configdir = '/etc/nginx/'
      $logdir = '/var/log/nginx'
      $servicename = 'nginx'
      $nginxuser = 'nginx'
    }
  }
      
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
    require => Package['nginx'],
    }
  file { '/etc/nginx/conf.d/default.conf':
    source => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'],
    }
  file { '/var/www/index.html':
    source => 'puppet:///modules/nginx/index.html',
    }
  service { 'nginx':
    ensure => 'running',
    subscribe => [File['/etc/nginx/nginx.conf'],File['/etc/nginx/conf.d/default.conf']],
    }
}
  
