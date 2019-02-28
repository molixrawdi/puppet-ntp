# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ntp::ntppackageinstall
class ntp::ntppackageinstall {
  package { 'ntp':
    ensure => 'installed',
    before => Class['ntp::ntpconfilesetup'],
  }
}
