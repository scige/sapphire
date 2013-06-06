class DeployDatum
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :status, type: String, :default => Setting.deploy_datum_status.new

  field :title, type: String

  field :svn_config, type: String

  field :rec_package, type: String
  field :rerank_package, type: String

  field :site_package, type: String
  field :item_package, type: String
  field :trim_package, type: String
  field :query_package, type: String
  field :aliguess_package, type: String
  field :filter_package, type: String
  field :indepsite_package, type: String
  field :ibcf_package, type: String
  field :taobao_package, type: String

  attr_accessible :status, :title, :svn_config, :rec_package, :rerank_package, :site_package, :item_package, :trim_package, :query_package, :aliguess_package, :filter_package, :indepsite_package, :ibcf_package, :taobao_package

  validates_presence_of :status
  validates_presence_of :title

  validate :at_least_one_package

  def at_least_one_package
    return if self.svn_config and !self.svn_config.empty?
    return if self.rec_package and !self.rec_package.empty?
    return if self.rerank_package and !self.rerank_package.empty?
    return if self.site_package and !self.site_package.empty?
    return if self.item_package and !self.item_package.empty?
    return if self.trim_package and !self.trim_package.empty?
    return if self.query_package and !self.query_package.empty?
    return if self.aliguess_package and !self.aliguess_package.empty?
    return if self.filter_package and !self.filter_package.empty?
    return if self.indepsite_package and !self.indepsite_package.empty?
    return if self.ibcf_package and !self.ibcf_package.empty?
    return if self.taobao_package and !self.taobao_package.empty?
    errors[:base] << "at least one package"
  end
end
