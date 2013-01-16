class TableSchema
  include Mongoid::Document
  include Mongoid::Timestamps

  field :table, type: String
  field :version, type: String
  field :owner, type: String

  embeds_many :table_fields
  accepts_nested_attributes_for :table_fields

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
