# $modulepath/nginx/manifests/init.pp

class nginx {
  package { 'nginx': 
    ensure => 'present',
    }
    
  
