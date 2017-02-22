class nginx {
  package {'nginx',
  ensure => present,
  }
 file {'/var/www' :
  ensure => file,
  owner  => 'root',
  group  => 'root',
  mode  =>  '0755',
  }
 file {'/etc/nginx/ngxin.conf':
  ensure => file,
  owner => 'root',
  group => 'root'
  mode => '0755'
  source => '/etc/nginx/conf.d/default.conf',
  }
