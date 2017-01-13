# PRIVATE CLASS: do not use directly
class mongodb::repo::yum inherits mongodb::repo {
  # We try to follow/reproduce the instruction
  # http://docs.mongodb.org/manual/tutorial/install-mongodb-on-red-hat-centos-or-fedora-linux/

  $yumreponame = "mongodb-org-${mongodb::params::version}"

  if($::mongodb::repo::ensure == 'present' or $::mongodb::repo::ensure == true) {
    yumrepo { "${yumreponame}":
      descr          => $::mongodb::repo::description,
      baseurl        => $::mongodb::repo::location,
      gpgcheck       => '1',
      enabled        => '1',
      gpgkey         => $::mongodb::repo::gpg_key,
      proxy          => $::mongodb::repo::proxy,
      proxy_username => $::mongodb::repo::proxy_username,
      proxy_password => $::mongodb::repo::proxy_password,
    }
    Yumrepo["${yumreponame}"] -> Package<|tag == "${yumreponame}"|>
  }
  else {
    yumrepo { "${yumreponame}":
      enabled => absent,
    }
  }
}
