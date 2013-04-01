module DeployDataHelper
  def get_package_option(package_name)
    options = [[nil, nil]]
    options += @our_package_hash[package_name].map {|o| [o, o]}
  end
end
