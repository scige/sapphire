module DeployDataHelper
  def get_package_option(package_name)
    options = [[nil, nil]]
    if @our_package_hash.has_key?(package_name)
      options += @our_package_hash[package_name].map {|o| [o, o]}
    end
    return options
  end
end
