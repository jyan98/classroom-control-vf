class nginx {
  case $facts['os']['family'] {
    'redhat','debian': {
      $package='nginx'
      $owner='root'
      $group='root'
      $docroot='/var/www'
      $confdir='/etc/nginx'
      $logdir='/var/log/nginx'
    }
    'windows': {
      $package='nginx-service'
      $owner='Administrator'
      $group='Administrators'
      $docroot='C:/programdata/nginx/html'
      $confdir='C:/programdata/nginx'
      $logdir='C:/programdata/nginx/logs'
    }
    'default': {
      fail("Module ${module_name} is not supported on ${facts['os']['family']} systems")
    }
  }
  case $facts['os']['family'] {
    'redhat': {
      $user='nginx'
    }     
    'debian': {
      $user='www-data'
    }     
    'windows': {
      $user='nobody'
    }
  }
    
  File {
    ensure => file,
    owner => $owner,
    group => $group,
    mode => '0644',
  }
  
  package { $package:
    ensure => present,
  }
  
  file { [$docroot,"${confdir}/config.d"]:
    ensure => directory,
  }

  file { "${docroot}/index.html":
    source  => 'puppet:///modules/nginx/index.html',
  }
 
  file { "${confdir}/nginx.conf":
    content => epp('nginx/nginx.conf.epp',
      {
        user => $user,
        confdir => $confdir,
        logdir => $logdir
      }),
    require => Package[$package],
    notify  => Service['nginx'],
  }
  
  file { "${confdir}/default.conf":
    content => epp('nginx/default.conf.epp',
      {
        docroot => $docroot,
      }),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
  
  service { 'nginx':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    subscribe => [File["${confdir}/nginx.conf"],File["${confdir}/default.conf"]]
  }
  
}
