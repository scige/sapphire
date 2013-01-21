class RecommendConfig
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :table_schema

  validates_presence_of :table_schema_id

  index :table_schema_id => 1
end
