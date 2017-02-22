class nginx {
  case $facts['os']['family'] {
    'RedHat': { 
      $service_user = 'nginx'
    }
    'Debian': {   
      $service_user = 'www-data'
    }
    'Windows': { 
      $service_user = 'nobody'
    }
    default: { fail("Operating system family ${facts['os']['family']} is not supported.") }
  }
  if $facts['os']['family'] == 'Windows' {
    $package_name = 'nginx-service'
    $serverblock_dir = 'C/ProgramData/nginx/conf.d'
    $logs_dir = 'C/ProgramData/nginx/logs'
    $document_root = 'C/ProgramData/nginx/html'
    $file_owner = 'Administrator'
    $file_group = 'Administrators'
    $config_dir = 'C/ProgramData/nginx'
  } else {
    $package_name = 'nginx'
    $serverblock_dir = '/etc/nginx/conf.d'
    $logs_dir = '/var/log/nginx'
    $document_root = '/var/www'
    $file_owner = 'root'
    $file_group = 'root'
    $config_dir = '/etc/nginx'
  }
  File {
    owner => $file_owner,
    group => $file_group,
    mode => '0644',
  }
  
  package { $package_name:
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
  
  file { "${config_dir}/nginx.conf":
    ensure => file,
    require => Package['nginx'],
    content => epp('nginx/nginx.conf.epp', {
      service_user => $service_user,
      logs_dir => $logs_dir,
      serverblock_dir => $serverblock_dir,
    }),
  }
  
  file { "${config_dir}/conf.d/default.conf":
    ensure => file,
    content => epp('nginx/default.conf.epp', { document_root => $document_root, }),
    require => Package['nginx'],
  }
  
  service {'nginx':
    ensure => running,
    enable => true,
    subscribe => File["${config_dir}/nginx.conf", "${config_dir}/conf.d/default.conf"],
  }
  
}
