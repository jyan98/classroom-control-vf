# $modulepath/nginx/manifests/init.pp

  
class nginx {

  case $facts['os']['name']{
    'redhat','centos': {
      $package = 'nginx'
      $owner = 'root'
      $group = 'root'
      $docroot = '/var/www'
      $configdir = '/etc/nginx'
      $logdir = '/var/log/nginx'
      $servicename = 'nginx'
      $nginxuser = 'nginx'
      $rundir = '/var/run'
    }
    'debian','ubuntu': {
      $package = 'nginx'
      $owner = 'root'
      $group = 'root'
      $docroot = '/var/www'
      $configdir = '/etc/nginx'
      $logdir = '/var/log/nginx'
      $servicename = 'nginx'
      $nginxuser = 'www-data'
      $rundir = '/var/run'
    }
    'windows': {
      $package = 'nginx-service'
      $owner = 'Administrator'
      $group = 'Administrators'
      $docroot = 'C:/ProgramData/nginx/html'
      $configdir = 'C:/ProgramData/nginx/'
      $logdir = 'C:/ProgramData/nginx/logs'
      $servicename = 'nginx'
      $nginxuser = 'nobody'
      $rundir = 'C:/ProgramData/nginx/run'
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
    name   => $package,
    }
  
  file { "$docroot" :
    ensure => 'directory',
    }
  file { "${configdir}/nginx.conf" :
    content => epp('nginx/nginx.conf.epp', {
      nginxuser => $nginxuser,
      logdir    => $logdir,
      rundir    => $rundir,
      configdir => $configdir,
      }),
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
  
