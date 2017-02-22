class nginx {
  
   package { 'nginx':
    ensure => 'installed'
   }
   
   file { '/var/www':
    ensure => 'directory',
    user => 'root',
    group => 'root',
    mode => '0775',
   }
   
   file { '/var/www/index.html':
    ensure => 'file',
    user => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet://modules/nginx/index.html',
   } 
    
   file { '/etc/nginx/nginx.conf':
    ensure => 'file',
    user => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet://modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify => Service['nginx'],
   } 
   
   file { '/etc/nginx/conf.d':
    ensure => 'directory',
    user => 'root',
    group => 'root',
    mode => '0775',
   }
   
   file { '/etc/nginx/conf.d/default.conf':
    ensure => 'file',
    user => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet://modules/nginx/conf.d/default.conf',
    require => Package['nginx'],
    notify => Service['nginx'],
   } 
   
   service { 'nginx':
    ensure => 'running',
    enable => 'true'
   }

}
