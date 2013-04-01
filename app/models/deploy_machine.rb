class DeployMachine
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :status, type: String, :default => Setting.deploy_machine_status.active
  field :host, type: String
  field :agent, type: String
  field :directory, type: String

  attr_accessible :name, :status, :host, :agent, :directory

  validates_presence_of :name, :status, :host, :agent, :directory
end
