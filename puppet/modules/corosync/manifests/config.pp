class corosync::config(
  $conf_dir       = '/etc/corosync',
  $auth_enabled   = false,
  $multicast_ip   = $corosync::params::multicast_ip,
  $multicast_port = $corosync::params::multicast_port,
){

  File{
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  file { $conf_dir :
    ensure  => directory,
  }

  file { "${conf_dir}/corosync.conf" :
    ensure  => file,
    content => template('corosync/etc/corosync/corosync.conf.erb'),
    require => File[$conf_dir],
  }

  file { "${conf_dir}/service.d" :
    ensure  => directory,
    mode    => '0755',
    recurse => true,
    purge   => true,
    require => File[$conf_dir],
  }

  file { '/etc/default/corosync' :
    ensure  => file,
    content => template('corosync/etc/default/corosync.erb'),
  }
}
