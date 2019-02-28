# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ntp::ntpservicesetup
class ntp::ntpservicesetup {
  service { 'ntpd':
    ensure => 'running',
    enable => true,
    require => Package['ntp'],
  }
}
