class TagRecommendConfig
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :tag_table_schema

  validates_presence_of :tag_table_schema_id

  index :tag_table_schema_id => 1
end
