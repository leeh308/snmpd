# Class: snmpd
#
# This module will at some point manage snmpd to allow reporting to our PRTG reporting system
#
# Parameters: none
#
# Actions:
#   install snmpd
#   copy new snmpd.conf file
#   copy new snmpd file
#   restart snmp 
#
# Requires: see Modulefile
#   snmpd.conf  justs needs "rocommunity public" as text
#   snmpd file
#
# Sample Usage:
# class snmpd

class snmpd {
  
service { 'snmpd':
  name => 'snmpd',
    ensure => running,
      enable => true,
        require => Package ['snmpd'],
        }
  
  package {'snmpd':
  ensure => installed,
          }
  
 file { '/etc/snmp/snmpd.conf':
    ensure => present,
      require => Package['snmpd'],
        source => "puppet:///modules/snmpd/snmpd.conf",
      }
#
# need to add snmpd as well and then restart snmpd service
#
file { '/etc/default/snmpd':
   ensure => present,
    require => Package ['snmpd'],
      source => "puppet:///modules/snmpd/snmpd",
     }
 }
#
#Need to restart snmpd to force changes
#
service { 'snmpd':
  ensure => running,
    enable => true,
      require => Package ['snmpd']
        }
#        
file { '/etc/default/snmpd':
  notify => Service ['snmpd'],
    require => Package ['snmpd']
      }
