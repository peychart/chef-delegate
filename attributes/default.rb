#
# Cookbook Name:: chef-delegate
# Attributes:: chef-delegate
#
default['chef-delegate']['options'] = ['-P3129', 'STLS="-fcl"', 'SERVER="ftp"']
default['chef-delegate']['paramsFilePath'] = '/usr/local/etc/delegate/'
#and:
#default['chef-delegate']['paramsFileName']['callOption'] = ''
#default['chef-delegate']['paramsFileName']['rules'] = []
#eg:
#    default['chef-delegate']['permit']['callOption'] = 'PERMIT="ftp:+=permit"'
#    default['chef-delegate']['permit']['rules'] = {'*:192.168.0.0/24', '*:192.168.1.11/32'}
