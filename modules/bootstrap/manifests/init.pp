class bootstrap::params {
  case $::operatingsystem {
    'Ubuntu': {
    }

    default: {
      fail("The ${module_name} module is not supported on ${::operatingsystem} operating system.")
    }
  }
}

class bootstrap::config (
   $puppetmaster = 'puppet.local',
   $gitrepo
) inherits bootstrap::params {

  file {'/etc/r10k.yaml':
    ensure   => file,
    content  => template('bootstrap/r10k.yaml.erb'),
    owner    => root,
    group    => root,
    mode     => '0644',
  }

  file {'/etc/puppet/hiera.yaml':
    ensure    => file,
    content   => template('bootstrap/hiera.yaml.erb'),
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
    ensure    => file,
    content   => template('bootstrap/common.yaml.erb'),
    owner     => root,
    group     => root,
  }

  

}

class bootstrap::install inherits bootstrap::params {

  package {'git': 
    ensure => present
  }

  package {'rubygems':
    ensure => present
  }

  package {'r10k':
    ensure   => present,
    provider => gem,
    require => Package ['rubygems'],
  }

  package {'deep_merge':
    ensure   => present,
    provider => gem,
    require => Package ['rubygems'],
  }

}

class bootstrap {
  include '::bootstrap::install'
  include '::bootstrap::config'

  Class['::bootstrap::install'] -> Class['::bootstrap::config']
}

