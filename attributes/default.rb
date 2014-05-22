default['gatling']['user']            = 'gatling'
default['gatling']['group']           = 'gatling'
default['gatling']['install_prefix']  = '/usr/local'
default['gatling']['download_url']    = 'INSERT GATLING DOWNLOAD URL HERE'       # fill this in from http://gatling-tool.org/
default['gatling']['version']         = '2.0.0-M3a'                              # fill this in too

# Gatling 2 requires Java 7
default["java"]["install_flavor"] = "oracle"
default["java"]["jdk_version"] = 7
default["java"]["oracle"]["accept_oracle_download_terms"] = true
