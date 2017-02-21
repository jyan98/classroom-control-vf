file { '/etc/motd':
  ensure  => file,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  content => "Hey, Puppet is fun!\nAnd I'm funner.\n",
}

package { 'cowsay':
  ensure   => present,
  provider => gem,
}
