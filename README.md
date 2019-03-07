Welcome to the 'NTP' module. This structure was generated through the use of PDK, the PDK documentation at https://puppet.com/pdk/latest/pdk_generating_modules.html .


#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with ntp](#setup)
    * [What ntp affects](#what-ntp-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with ntp](#beginning-with-ntp)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Hiera usage](#Hiera)

## Description

This module's purpose was to install the 'NTP' time daemon with a standard configuration.


## Setup

### What ntp affects 


This is designed to install 'NTP" on a Centos,Redhat,Or Scientific Linux version 7, supporting 64-bit architecture Intel/AMD. This is tested on Centos7 64 bit. 

* Relies on '/etc/ntp.conf'.
* Dependencies are resolved by the standard Centos, Redhat repo for yum.
* Activating the module through 'puppet apply' will by via applying the node/manifests/default.pp, this is represented in the diagram below, more (roles) can be added to the node, more profiles can be added to a role, this will depend on how complex is the desired implementation and the number of components. 


```
[node]----->[role(s)]------->[profile(s)]------------->[target-class(ntp)]

```

The expansion on the number of roles,files and modules(classes) can be seen in the diagram representation below:

```

                                                                                    ------>[class]
                                                                                    |
                                                          ------------->[module]----|----->[class]
                                                          |                         
[node(default)---->                 -------->[profile]-----   ----------[module]----------->[class]
                  |                 |                         |                    |
                  ------>[role]------------->[profile]------->|                    -------->[class]
                  |
                  ------>[role]------------->[profile]--------------->|--->[module]---->[class] 
                  |                                                   |
                  ------>[role]------------->[profile]|               ---->[module]---->[class] 
                                                      |
                                                      |                  ----[class]
                                                      |                  |             ---->[class]
                                                      ---------->[module]|-->[class]---| 
                                                                                        ---->[class]
   

```

### Setup Requirements/options

This module comes with 3 more modules that are designed to run in conjunction with it . They are 'role', 'profile' and 'node'.
'profile' will call the main class in this module, this is contained within the file 'init.pp' the main class is 'ntp'. 'profile' should be placed at '/etc/puppetlabs/code/modules', to achieve seperation of Management from code.
'role' will call the profile, can have many more profiles attached to build more complex role if needed. Placed at '/etc/puppetlabs/code/modules,
'node' will call the role, can have more roles attached to it. This will depend on the requirement, placed at '/etc/puppetlabs/code/modules/. Node is set to default so that it installs on the machine where it resides, (master-less-puppet)
This module should be placed at '/etc/puppetlabs/code/environments/<environment>/modules

### Beginning with ntp
 A basic setup of ntp, has the stop start and status basic functions to run from command line. comes with the basic out of the box ntp setup. Uses centos time servers, please check to see if these settings are suitable for your usage


## Usage

```
### `systemctl status ntp.service`

#### 'systemctl start ntp.service'

##### `systemctl stop ntp.service`

```


## Limitations

Designed for Redhat 7 based systems on a 64 bit archiecture.
The class ntp can only be implemented through the profile,role,node or via the linking method presented in the diagram, to implement the class/module 'ntp' individualy, one must de-construct it to its basic elements, these elements will be the resources contained in a typical class(s), (file,package,exec,service).

##Hiera

In this example (module) hiera variable mapping was utilized to establish values for several elements embeded in the 'ntp.conf' file. For reference  this file is the configuration file for this module. The aim of this module was to establish the awareness of hiera and its benefits.

The file heira.yaml would have a key to this common.yaml target file which has the variables

```
# common.yaml This file resides inside the module 'ntp/data/common.yaml'


ntp::motd_message: "This is a vagrant host testing puppet ntp service"
ntp::ntp_server01: '0.centos.pool.ntp.org'
ntp::ntp_server02: '1.centos.pool.ntp.org'
ntp::ntp_server03: '2.centos.pool.ntp.org'
ntp::ntp_server04: '3.centos.pool.nts.org'
ntp::restrict_value: '127.0.0.1'
ntp::drift_file: '/var/lib/ntp/drift'


```

Below is the file template, which is a file with the 'epp' extension, this is the new format for puppet templating, the other is the 'erb'. The 'epp' seems to be the most preferred or popular.

```

#public servers from the pool.ntp.org project.
# Please consider joining the pool (http://www.pool.ntp.org/join.html).

 server <%= lookup('ntp::ntp_server01') %> iburst
 server <%= lookup('ntp::ntp_server02') %> iburst
 server <%= lookup('ntp::ntp_server03') %> iburst
 server <%= lookup('ntp::ntp_server04') %> iburst

# # Ignore stratum in source selection.
 stratumweight 0
#
# # Record the rate at which the system clock gains/losses time.

driftfile <%= lookup('ntp::drift_file') -%>


# # Enable kernel RTC synchronization.
 rtcsync
#
# # In first three updates step the system clock instead of slew
# # if the adjustment is larger than 10 seconds.
 makestep 10 3
#
# # Listen for commands only on localhost.
 bindcmdaddress 127.0.0.1
# bindcmdaddress ::1

restrict <%= lookup('ntp::restrict_value') -%>

# keyfile /etc/chrony.keys
#
# # Specify the key used as password for chronyc.
 commandkey 1
#
# # Generate command key if missing.
 generatecommandkey
#
# # Disable logging of client accesses.
 noclientlog
#
# # Send a message to syslog if a clock adjustment is larger than 0.5 seconds.
 logchange 0.5
#
 logdir /var/log/chrony

```

