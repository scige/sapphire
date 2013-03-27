class DeployMachine
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :status, type: String
  field :address, type: String
  field :agent, type: String
  field :directory, type: String

  attr_accessible :name, :status, :address, :agent, :directory
end
