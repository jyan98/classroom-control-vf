class nginx {
File {
ensure => file,
owner => 'root',
group => 'root',
mode => '0664',
}
package { 'nginx':
ensure => present,
}
file { [ '/var/www', '/etc/nginx/conf.d' ]:
ensure => directory,
}
file { '/var/www/index.html':
source => 'puppet:///modules/nginx/index.html',
}
file { '/etc/nginx/nginx.conf':
source => 'puppet:///modules/nginx/nginx.conf',
require => Package['nginx'],
notify => Service['nginx'],
}
file { '/etc/nginx/conf.d/default.conf':
source => 'puppet:///modules/nginx/default.conf',
notify => Service['nginx'],
require => Package['nginx'],
}
service { 'nginx':
ensure => running,
enable => true,
}
}
