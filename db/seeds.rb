# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ts = TableSchema.create(:table=>"sites", :version=>"trunk", :owner=>"online")

ts.table_fields << TableField.new(:name=>"scope", :label=>"scope", :group=>"key")
ts.table_fields << TableField.new(:name=>"scope_type", :label=>"scope_type", :group=>"key")
ts.table_fields << TableField.new(:name=>"domain", :label=>"domain", :group=>"key")

ts.table_fields << TableField.new(:name=>"source", :label=>"source", :group=>"basic")
ts.table_fields << TableField.new(:name=>"timeliness", :label=>"timeliness", :group=>"basic")

ts.table_fields << TableField.new(:name=>"fetch_count", :label=>"fetch_count", :group=>"alg_1")
ts.table_fields << TableField.new(:name=>"enable", :label=>"enable", :group=>"alg_1")

ts.save

ts2 = TableSchema.create(:table=>"item_pattern", :version=>"trunk", :owner=>"offline")
ts2.table_fields << TableField.new(:name=>"domain", :label=>"domain", :group=>"key")
ts2.table_fields << TableField.new(:name=>"pattern", :label=>"pattern", :group=>"value")
ts2.save

ts3 = TableSchema.create(:table=>"image", :version=>"trunk", :owner=>"flow")
ts3.table_fields << TableField.new(:name=>"url", :label=>"url", :group=>"key")
ts3.table_fields << TableField.new(:name=>"image_url", :label=>"image_url", :group=>"value")
ts3.save
