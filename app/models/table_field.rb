class TableField
  include Mongoid::Document
  include Mongoid::Timestamps

  field :group, :type => String
  field :label, :type => String
  field :name, :type => String
  field :default_value, :type => String, :default => ""
  field :help_text, :type => String, :default => ""
  field :field_type, :type => String, :default => ""

  embedded_in :table_schema

  validates_presence_of :group, :label, :name

  attr_accessible :group, :label, :name, :default_value, :help_text, :field_type
end
