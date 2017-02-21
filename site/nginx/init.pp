# $modulepath/users/nginx/init.pp
class nginx: {
  package { 'nginx':
    ensure => 'installed',
    }
  file { '/var/www':
    ensure => 'directory',
    }
  file { '/var/www/default/index.html':
    content => 'present',
  }
  file { '/var/www/index.html':
    ensure  => file,
    content => file("${module_name}/index.html"),
  }
  file { '/etc/nginx/nginx.conf':
    ensure  => file,
    content => file("${module_name}/nginx.conf"),
    notify  => Service['nginx'],
  }
  file { '/etc/nginx/conf.d':
    ensure => directory,
  }
  file { '/etc/nginx/conf.d/default.conf':
    ensure  => file,
    content => file("${module_name}/default.conf"),
    notify  => Service['nginx'],
  }
  service { 'nginx':
    ensure     => running,
    enable     => true,
    hasrestart => true,
  }
}
