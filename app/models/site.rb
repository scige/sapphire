class Site < ActiveRecord::Base
  attr_accessible :domain, :scope, :scope_type
end
