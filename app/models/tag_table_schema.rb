class TagTableSchema
  include Mongoid::Document
  include Mongoid::Timestamps

  field :table, type: String
  field :version, type: String
  field :owner, type: String

  embeds_many :table_fields
  accepts_nested_attributes_for :table_fields, :allow_destroy => true

  has_many :tag_recommend_configs

  attr_accessible :table_fields_attributes, :table, :version, :owner

  def groups
    groups = []
    self.table_fields.each do |table_field|
      groups << table_field.group
    end
    groups.uniq
  end

  def clone_with_table_schema(table_schema)
      self.table   = table_schema.table
      self.version = table_schema.version
      self.owner   = table_schema.owner

      table_schema.table_fields.each do |table_field|
          #TODO: table_field的created_at和updated_at都不是当前时间
          self.table_fields << table_field
      end
  end
end
