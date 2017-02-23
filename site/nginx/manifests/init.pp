class nginx{
  case $facts['os']['family'] {
    'debian','redhat': {
      $package = 'nginx'
      $owner = 'root'
      $group = 'root'
      $rootdir = '/var/www'
      $confdir = '/etc/nginx'
      $logdir = '/var/log'
     }
    'windows': {
      $package = 'nginx-service'
      $owner = 'Administrator'
      $group = 'Administrators'
      $confdir = 'C:/ProgramData/nginx'
      $rootdir = "${confdir}/html"
      $logdir = "${confdir}/logs"  
    }
    default: {
      fail("Operating system family ${facts['os']['family']} is not supported.")
    }
  }
  $user = $facts['os']['family'] ? {
    'debian' => 'www-data',
    'redhat' => 'nginx',
    'windows' => 'nobody',
  }
  
  
  $nginxdirs=[$rootdir,$confdir,"${confdir}/conf.d",$logdir]
  
  File {
    ensure  => 'file',
    mode    => '0644',
    owner   => $owner,
    group   => $group,
  }
  
  package { $package:
    ensure => present,
  }
  service { 'nginx':
    ensure     => running,
    enable     => true,
    hasrestart => true,
  }
  
  file { $nginxdirs:
    ensure => 'directory',
    mode   => '0755',
    owner  => $owner,
    group  => $group,
  }
  
  file { "${confdir}/nginx.conf":
    source  => 'puppet:///modules/nginx/nginx.conf',
    notify  => Service['nginx'],
    require => Package[$package],
  }
  file { "${confdir}/conf.d/default.conf":
    source  => 'puppet:///modules/nginx/default.conf',
    notify  => Service['nginx'],
    require => Package[$package],
  }
  file { "${rootdir}/index.html":
    source  => 'puppet:///modules/nginx/index.html',
  }
}
