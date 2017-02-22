class nginx {
  package { 'nginx':
    ensure => present,
  }
  
  file { '/var/www':
    ensure => 'directory',
    owner => 'root',
    group => 'root',
    mode => '644',
  }
  
  
}
