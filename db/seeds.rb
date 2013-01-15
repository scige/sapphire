# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ts = TableSchema.create(:table=>"sites", :version=>"0.0.1", :owner=>"online")

ts.table_fields << TableField.new(:name=>"scope", :label=>"scope", :group=>"key")
ts.table_fields << TableField.new(:name=>"scope_type", :label=>"scope_type", :group=>"key")
ts.table_fields << TableField.new(:name=>"domain", :label=>"domain", :group=>"key")

ts.table_fields << TableField.new(:name=>"source", :label=>"source", :group=>"basic")
ts.table_fields << TableField.new(:name=>"timeliness", :label=>"timeliness", :group=>"basic")

ts.table_fields << TableField.new(:name=>"fetch_count", :label=>"fetch_count", :group=>"alg_1")
ts.table_fields << TableField.new(:name=>"enable", :label=>"enable", :group=>"alg_1")

ts.save
