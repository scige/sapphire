class DeployDatum
  include Mongoid::Document
  include Mongoid::Timestamps

  field :status, type: String, :default => Setting.deploy_datum_status.new

  field :rec_package, type: String
  field :rerank_package, type: String

  field :site_package, type: String
  field :item_package, type: String
  field :trim_package, type: String
  field :query_package, type: String
  field :aliguess_package, type: String

  attr_accessible :status, :rec_package, :rerank_package, :site_package, :item_package, :trim_package, :query_package, :aliguess_package

  validates_presence_of :status

  validate :at_least_one_package

  def at_least_one_package
    return if self.rec_package and !self.rec_package.empty?
    return if self.rerank_package and !self.rerank_package.empty?
    return if self.site_package and !self.site_package.empty?
    return if self.item_package and !self.item_package.empty?
    return if self.trim_package and !self.trim_package.empty?
    return if self.query_package and !self.query_package.empty?
    return if self.aliguess_package and !self.aliguess_package.empty?
    errors[:base] << "at least one package"
  end
end
