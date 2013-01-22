module TableSchemasHelper
  def get_options(option_string)
    option_array = option_string.split(',')
    option_array.each do |option|
      option.strip!
    end
    option_array.map {|o| [o, o]}
  end
end
