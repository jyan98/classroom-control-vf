# init.pp file for demo

class nginx_class_demo {
  package { 'nginx':
   ensure => 'installed',
  }
  
}
