class RecommendConfig
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :table_schema
end
