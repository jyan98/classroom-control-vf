class nginx {
  
   package { 'nginx':
    ensure => 'installed'
   }
   
   file { '/var/www':
    ensure => 'directory',
    owner => 'root',
    group => 'root',
    mode => '0775',
   }
   
   file { '/var/www/index.html':
    ensure => 'file',
    owner => 'root',
    group => 'root',
    mode => '0644',
    content => file("${module_name}/index.html),
   } 
    
   file { '/etc/nginx/nginx.conf':
    ensure => 'file',
    owner => 'root',
    group => 'root',
    mode => '0644',
    content => file("${module_name}/nginx.conf),
    require => Package['nginx'],
    notify => Service['nginx'],
   } 
   
   file { '/etc/nginx/conf.d':
    ensure => 'directory',
    owner => 'root',
    group => 'root',
    mode => '0775',
   }
   
   file { '/etc/nginx/conf.d/default.conf':
    ensure => 'file',
    owner => 'root',
    group => 'root',
    mode => '0644',
    content => file("${module_name}/default.conf),
    require => Package['nginx'],
    notify => Service['nginx'],
   } 
   
   service { 'nginx':
    ensure => 'running',
    enable => 'true'
   }

}
