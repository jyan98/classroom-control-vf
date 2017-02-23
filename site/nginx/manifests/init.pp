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
  group => "${group}",
  owner => "${owner}",
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
  file { "${configdir}/conf.d/default.conf":
    content  => epp('nginx/default.conf.epp', {
      docroot => $docroot
      }),
    require => Package['nginx'],
    }
  file { "${docroot}/index.html":
    source => 'puppet:///modules/nginx/index.html',
    }
  service { 'nginx':
    ensure => 'running',
    subscribe => [File["${configdir}/nginx.conf"],File["${configdir}/conf.d/default.conf"]],
    }
}
  
