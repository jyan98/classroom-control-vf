# users/manifests/init.pp

class site::users {
  user { 'fundamentals':
    ensure => present,
  }
}
