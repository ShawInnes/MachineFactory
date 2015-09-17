if defined?(ChefSpec)
  ChefSpec.define_matcher :windows_firewall_rule

  def create_windows_firewall_rule(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:windows_firewall_rule, :create, resource_name)
  end
end
