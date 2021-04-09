[root@puppet-master manifests]# cat jenkins.pp
# install java pre-req package
package { 'java-1.8.0-openjdk-devel':
  ensure => installed,
}

# install jenkins yum repo
yumrepo { 'jenkins_repo' :
  enabled  => 1,
  descr    => 'Jenkins Repo',
  baseurl  => 'http://pkg.jenkins-ci.org/redhat-stable',
  gpgcheck => 0,
}

# install jenkins
package { 'jenkins':
  ensure => installed,
}

# modify config file

file {'jenkins config':
  ensure => file,
  path   => '/etc/sysconfig/jenkins',
  source => '/etc/puppet/manifests/jenkins',
}

# start jenkins
service { 'jenkins':
  ensure => running,
  enable => true,
}