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

  def group_fields
      group_fields_hash = {}
      self.table_fields.each do |field|
          if group_fields_hash.has_key?(field.group)
              group_fields_hash[field.group] << field
          else
              group_fields_hash[field.group] = [field]
          end
      end

      return group_fields_hash
  end
end