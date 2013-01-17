class TagRecommendConfig
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :tag_table_schema
end
