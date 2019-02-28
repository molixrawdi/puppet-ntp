# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include node::nntp
#   include ntp
class node::nntp {
  node 'default' {
  class {role::rntp:}
  }
}
