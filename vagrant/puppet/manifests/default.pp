Package {
  provider => chocolatey,
}
  
package { "notepadplusplus" :
  ensure => "latest"
}
  
package { "wget" :
  ensure => "latest"
}

package { "octopusdeploy" :
  ensure => "latest"
}

dsc_windowsfeature {'IIS':
  dsc_ensure => 'present',
  dsc_name   => 'Web-Server',
} ->

dsc_windowsfeature {'AspNet45':
  dsc_ensure => 'present',
  dsc_name   => 'Web-Asp-Net45',
} ->

dsc_xwebsite {'Stop DefaultSite':
  dsc_ensure       => 'present',
  dsc_name         => 'Default Web Site',
}

