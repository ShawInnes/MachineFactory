# Cookbook Name:: sqlserver
# Recipe:: default
#
# Copyright (c) 2014 Ryan Irujo, All Rights Reserved.
 
# Declaring Variables
iso_file          = "en_sql_server_2014_developer_edition_x64_dvd_3940406.iso"
iso_url           = "http://server.devops/#{iso_file}"
iso_path          = "C:\\Install\\#{iso_file}"
sql_svc_act       = "svcSqlServer"
sql_svc_pass      = "Password01"
sql_sysadmins     = "Administrator"
sql_agent_svc_act = "NT AUTHORITY\\Network Service"
 
# Creating a Temporary Directory to work from.
directory "C:\\Temp\\" do
	rights :full_control, "#{sql_svc_act}"
	inherits true
	action :create
end
 
# Download the SQL Server Standard ISO from a Web Share.
 
powershell_script 'Download SQL Server STD ISO' do
	code <<-EOH
		$Client = New-Object System.Net.WebClient
		$Client.DownloadFile("#{iso_url}", "#{iso_path}")
		EOH
	guard_interpreter :powershell_script
	not_if { File.exists?(iso_path)}
end
 
# Mounting the SQL Server SP1 Standard ISO.
powershell_script 'Mount SQL Server STD ISO' do
	code  <<-EOH
		Mount-DiskImage -ImagePath "#{iso_path}"
        if ($? -eq $True)
		{
			echo "SQL Server STD ISO was mounted Successfully." > C:\\temp\\SQL_Server_2012_STD_ISO_Mounted_Successfully.txt
			exit 0;
		}
		
		if ($? -eq $False)
        {
			echo "The SQL Server 2012 STD ISO Failed was unable to be mounted." > C:\\temp\\SQL_Server_2012_STD_ISO_Mount_Failed.txt
			exit 2;
        }
		EOH
	guard_interpreter :powershell_script
	not_if '($SQL_Server_ISO_Drive_Letter = (gwmi -Class Win32_LogicalDisk | Where-Object {$_.VolumeName -eq "SQLServer"}).VolumeName -eq "SQLServer")'
end
 
# Installing SQL Server 2012 Standard.
powershell_script 'Install SQL Server 2012 STD' do
	code <<-EOH
		$SQL_Server_ISO_Drive_Letter = (gwmi -Class Win32_LogicalDisk | Where-Object {$_.VolumeName -eq "SQLServer"}).DeviceID
		cd $SQL_Server_ISO_Drive_Letter\\
		$Install_SQL = ./Setup.exe /q /ACTION=Install /FEATURES=SQL /INSTANCENAME=MSSQLSERVER /SQLSVCACCOUNT="#{sql_svc_act}" /SQLSVCPASSWORD="#{sql_svc_pass}" /SQLSYSADMINACCOUNTS="#{sql_sysadmins}" /AGTSVCACCOUNT="#{sql_agent_svc_act}" /IACCEPTSQLSERVERLICENSETERMS	
		$Install_SQL > C:\\temp\\SQL_Server_2012_STD_Install_Results.txt
		EOH
	guard_interpreter :powershell_script
	not_if '((gwmi -class win32_service | Where-Object {$_.Name -eq "MSSQLSERVER"}).Name -eq "MSSQLSERVER")'
end
 
# Dismounting the SQL Server 2012 STD ISO.
powershell_script 'Delete SQL Server 2012 STD ISO' do
	code <<-EOH
		Dismount-DiskImage -ImagePath "#{iso_path}"
		EOH
	guard_interpreter :powershell_script
	only_if { File.exists?(iso_path)}
end
 
# Removing the SQL Server 2012 STD ISO from the Temp Directory.
powershell_script 'Delete SQL Server 2012 STD ISO' do
	code <<-EOH
		[System.IO.File]::Delete("#{iso_path}")
		EOH
	guard_interpreter :powershell_script
	only_if { File.exists?(iso_path)}
end
