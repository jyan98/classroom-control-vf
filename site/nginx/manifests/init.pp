class nginx {
  
   package { 'nginx':
    ensure => 'installed'
   }
   
   file { '/var/www':
    ensure => directory,
    user => 'nginx'
   }
   
   file { '/etc/nginx/nginx.conf':
    ensure => file,
    source => 'puppet://modules/nginx/nginx.conf',
   } 
   
   file { '/etc/nginx/default.conf':
    ensure => file,
    source => 'puppet://modules/nginx/default.conf',
   } 
   
   service { 'nginx':
    ensure => 'running'
   }

}
