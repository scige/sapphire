class TableField
  include Mongoid::Document
  include Mongoid::Timestamps

  field :group, :type => String
  field :label, :type => String
  field :name, :type => String
  field :required, :type => Boolean, :default => true
  field :help_text, :type => String
  field :field_type, :type => String

  embedded_in :table_schema

  validates_presence_of :name, :label, :group, :required

  attr_accessible :name, :label, :help_text, :required, :field_type, :group
end
