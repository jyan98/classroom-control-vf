class nginx {
  case $facts['os']['family'] {
    'RedHat': { $document_root = '/var/www' }
    'Windows': { $document_root = 'C/ProgramData/nginx/html' }
    default: { fail("Operating system family ${facts['os']['family']} is not supported.")
  }
  File {
    owner => 'nginx',
    group => 'nginx',
    mode => '0644',
  }
  
  package { 'nginx':
    ensure => present,
  }
  
  file { '/var/www':
    ensure => 'directory',
    require => Package['nginx'],
  }
  
  file { '/var/www/index.html':
    ensure => file,
    source => "puppet:///modules/${module_name}/index.html",
    require => File['/var/www'],
  }
  
  file { '/etc/nginx/nginx.conf':
    ensure => file,
    require => Package['nginx'],
    source => "puppet:///modules/${module_name}/nginx.conf",
  }
  
  file { '/etc/nginx/conf.d/default.conf':
    ensure => file,
    content => epp('nginx/default.conf.epp', { document_root => $document_root, }),
    require => Package['nginx'],
  }
  
  service {'nginx':
    ensure => running,
    enable => true,
    subscribe => File['/etc/nginx/nginx.conf', '/etc/nginx/conf.d/default.conf'],
  }
  
}
