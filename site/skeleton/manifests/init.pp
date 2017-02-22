class skeleton {

   file { '/etc/skel':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0750',
  }
  
  file { '/etc/skel/.bashrc':
    ensure => 'file',
    owner => 'root',
    group => 'root',
    mode => '0640',
    source => 'puppet:///modules/skeleton/bashrc',
  }
