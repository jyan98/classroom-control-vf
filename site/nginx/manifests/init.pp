
class nginx {
  File {
    ensure => file,
    owner => 'root',
    group => 'root',
    node => '0644',
   }
  package {'nginx':
  ensure => present,
   }
    
 file {'/var/www' :
  ensure => directory,
     }
  
file {'/var/www/index.html':
 source => 'puppet:///modules/nginx/index.html',
 }

 file {'/etc/nginx/ngxin.conf':
   source => 'puppet:///modules/nginx/nxgin.conf',
   require => Package['nginx'],
   }
 
 file {'/etc/nginx/conf.d'/default.conf':
  ensure=> directory,
  source => 'puppet:///modules/nginx/default.conf',
  require => Package['nginx'],
  }
  
 service {'nginx':
  ensure  => running,
  enable =>  true,
  require => Package['nginx'],
  }
 }
