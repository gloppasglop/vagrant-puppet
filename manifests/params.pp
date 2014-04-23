class bootstrap::params {
  case $::operatingsystem {
    'Ubuntu': {
    }

    default: {
      fail("The ${module_name} module is not supported on ${::operatingsystem} operating system.")
    }
}
