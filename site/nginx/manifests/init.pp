# $modulepath/nginx/manifests/init.pp

class nginx {
  package { 'nginx': 
    ensure => 'present',
    }
  file { '/var/www':
    ensure => 'directory',
    }
    
}
  
