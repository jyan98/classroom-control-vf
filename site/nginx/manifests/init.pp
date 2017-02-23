# $modulepath/nginx/manifests/init.pp

  
class nginx {

  case $facts['os']['family']{
    'redhat','centos': {
      $package = 'nginx'
      $owner = 'root'
      $group = 'root'
      $docroot = '/var/www'
      $configdir = '/etc/nginx'
      $logdir = '/var/log/nginx'
      $servicename = 'nginx'
      $user = 'nginx'
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
      $user = 'www-data'
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
      $user = 'nobody'
      $rundir = 'C:/ProgramData/nginx/run'
    }
    'default': {
      fail("Operating system ${facts['os']['family']} is not supported.")
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
    name => "${package}",
    }
  
  file { "$docroot" :
    ensure => 'directory',
    }
  file { "${configdir}/nginx.conf" :
    content => epp('nginx/nginx.conf.epp', {
      user      => $user,
      logdir    => $logdir,
      rundir    => $rundir,
      configdir => $configdir,
      }),
    require => Package["${package}"],
    notify => Service[ "${package}" ],
    }
  file { "${configdir}/conf.d/default.conf":
    content  => epp('nginx/default.conf.epp', {
      docroot => $docroot
      }),
    require => Package["${package}"],
    notify => Service[ "${package}" ],
    }
  file { "${docroot}/index.html":
    source => 'puppet:///modules/nginx/index.html',
    }
  service { $servicename:
    ensure => 'running',
    }
}
  
