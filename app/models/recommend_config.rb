class RecommendConfig
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :table_schema

  validates_presence_of :table_schema_id
end
