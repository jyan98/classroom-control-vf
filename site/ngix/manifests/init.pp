class ngix {
  file {
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode  =>  '0644',
}
  package { 'nginx':
    ensure => present,
}
file { '/var/www':
  ensure => directory,
  mode => '0775',
}
file { '/var/www/index.html':
  source => 'puppet:///modules/nginx/index.html',
}
file { '/etc/nginx/nginx.conf':
  source => 'puppet:///modules/nginx/nginx.conf',
  require => Package['nginx'],
  notify => Service['nginx'],
}
file { '/etc/nginx/conf.d':
  ensure => directory,
  mode => '0775',
}
file { '/etc/nginx/conf.d/default.conf':
  source => 'puppet:///modules/nginx/default.conf',
  require => Package['nginx'],
  notify => Service['nginx'],
}
service { 'nginx':
  ensure => running,
  enable => true,
}
}
