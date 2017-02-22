class skeleton {
  file { '/etc/skel':
    ensure => directory,
    user   => 'root',
    group  => 'root',
    mode   => '0755',
  }
  file { '/etc/skel/.bashrc':
    ensure => file,
    user   => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/skeleton/bashrc',
  }
}
