class TableSchema
  include Mongoid::Document
  include Mongoid::Timestamps

  field :table, type: String
  field :version, type: String
  field :owner, type: String

  embeds_many :table_fields
  accepts_nested_attributes_for :table_fields, :allow_destroy => true

  has_many :recommend_configs

  validates_presence_of :table, :version, :owner, :table_fields
  validates_uniqueness_of :table, :case_sensitive => false

  index :table => 1
  index :owner => 1

  attr_accessible :table_fields_attributes, :table, :version, :owner

  after_save :sort_table_fields

  def sort_table_fields
    temp_table_fields = self.table_fields.each do |field|
      if field.group == "key"
        field.group = " key"
      end
    end

    temp_table_fields.sort! do |left, right|
      [left.group, left.id] <=> [right.group, right.id]
    end

    temp_table_fields.each do |field|
      if field.group == " key"
        field.group = "key"
      end
    end

    self.table_fields = temp_table_fields
  end

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
