# Set this attribute to the version of sql server you wish to install
default['sqlserver']['version'] = '2015'

# Set this attribute to the edition of sql server you wish to install
default['sqlserver']['edition'] = 'developer'

# Installation directory
default['sqlserver']['install_dir'] = (ENV['ProgramFiles(x86)'] || 'C:\Program Files (x86)') + '\Microsoft Visual Studio 14.0'

# SQL Server 2014
default['sqlserver']['developer']['installer_file'] = 'vs_enterprise.exe'
default['sqlserver']['developer']['filename'] = 'en_sql_server_2014_developer_edition_x64_dvd_3940406.iso'
default['sqlserver']['developer']['package_name'] = 'Microsoft SQL Server 2014'
default['sqlserver']['developer']['checksum'] = '3b27bf590ed30c78278d8eab86e18fef8bf48a4fe02756d5cfc75cda111aa204'
