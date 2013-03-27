class DeployDatum
  include Mongoid::Document
  include Mongoid::Timestamps

  field :agg_config, type: String
  field :site_config, type: String

  field :rec_package, type: String
  field :rerank_package, type: String

  field :item_package, type: String
  field :trim_package, type: String
  field :query_package, type: String
  field :aliguess_package, type: String

  attr_accessible :agg_config, :site_config, :rec_package, :rerank_package, :item_package, :trim_package, :query_package, :aliguess_package
end
