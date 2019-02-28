# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ntp::ntpconfilesetup
class ntp::ntpconfilesetup {
  file {'/etc/ntp.conf':
   ensure => 'file',
   #content => template('ntp/ntp.conf.erb'),
   content => epp('ntp/ntp.conf.epp'), 
   before => Class['ntp::ntpservicesetup'],
  }
}
