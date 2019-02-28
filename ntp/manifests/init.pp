# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ntp
class ntp {

  class {ntp::ntppackageinstall:}
  class {ntp::ntpconfilesetup:}
  class {ntp::ntpservicesetup:}
}
