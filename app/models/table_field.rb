class TableField
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :label, type: String
  field :help_text, type: String
  field :required, type: Boolean
  field :field_type, type: String
  field :group, type: String

  embedded_in :table_schema
end
