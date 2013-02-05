class TableField
  include Mongoid::Document
  include Mongoid::Timestamps

  field :group, :type => String
  field :label, :type => String
  field :name, :type => String
  field :default_value, :type => String, :default => ""
  field :help_text, :type => String, :default => ""
  field :field_type, :type => String, :default => ""
  field :option_value, :type => String, :default => ""

  embedded_in :table_schema

  attr_accessible :group, :label, :name, :default_value, :help_text, :field_type, :option_value

  validates_presence_of :group, :label, :name
  validates_uniqueness_of :name, :scope => :group
  validates_inclusion_of :default_value, :in => lambda{|field| field.option_array}

  def option_array
    options = []
    if self.field_type == "select"
      options = self.option_value.split(',')
      options.each do |option|
        option.strip!
      end
    else
      options = [default_value]
    end
    return options
  end
end
