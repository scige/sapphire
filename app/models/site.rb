class Site
  include Mongoid::Document
  include Mongoid::Timestamps

  field :scope, type: String
  field :scope_type, type: String
  field :domain, type: String
end
