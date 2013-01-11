class Site
  include Mongoid::Document
  field :scope, type: String
  field :scope_type, type: String
  field :domain, type: String
end
