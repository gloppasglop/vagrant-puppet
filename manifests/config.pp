class bootstrap::config (
   puppetmaster = 'puppet.local'
   gitrepo      = undef
) inherits bootstrap::params {

  file {'/etc/r10k.yaml':
    ensure   => present,
    content  => template('r10k.yaml.erb'),
    owner    => root,
    group    => root,
    mode     => '0644',
  }

  file {'/etc/puppet/hiera.yaml':
    ensure    => present,
    content   => template('hiera.yaml.erb'),
    owner     => root,
    group     => root,
    mode      => '0644',
  }

  file {'/etc/puppet/hiera':
    ensure    => directory,
    owner     => root,
    group     => root,
  } ->
  file {'/etc/puppet/hiera/nodes':
    ensure    => directory,
    owner     => root,
    group     => root,
  } ->
  file {'/etc/puppet/hiera/common.yaml':
    ensure    => present,
    content   => template('common.yaml.erb'),
    owner     => root,
    group     => root,
  }

}
