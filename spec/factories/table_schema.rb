FactoryGirl.define do
  factory :table_field, class: TableField do
    group         "key"
    name          "domain"
    label         "domain"
    default_value ""
    help_text     ""
    field_type    "input"
    option_value  ""
  end

  factory :table_field_1, class: TableField do
    group   "key"
    name    "domain"
    label   "domain"
  end

  factory :table_field_2, class: TableField do
    group   "value"
    name    "pattern"
    label   "pattern"
  end

  factory :table_field_3, class: TableField do
    group   "value"
    name    "description"
    label   "description"
  end

  factory :table_field_4, class: TableField do
    group   "value"
    name    "transform"
    label   "transform"
    default_value "default"
  end

  factory :table_field_5, class: TableField do
    group   "algorithm"
    name    "alg_search"
    label   "alg_search"
  end

  factory :table_schema do
    table         "test"
    version       "trunk"
    owner         "sandbox"
    table_fields  {[FactoryGirl.build(:table_field_1),
                    FactoryGirl.build(:table_field_2)]}
  end

  factory :table_schema_three, class: TableSchema do
    table         "test"
    version       "trunk"
    owner         "sandbox"
    table_fields  {[FactoryGirl.build(:table_field_1),
                    FactoryGirl.build(:table_field_2),
                    FactoryGirl.build(:table_field_3)]}
  end

  factory :recommend_config do
    association   :table_schema
  end

  #factory :recommend_config_real, :parent=>:recommend_config do
  #  key      {{:domain=>"meishichina.com"}}
  #  value    {{:pattern=>"http://home.meishichina.com/*/*.html"}}
  #end

  factory :table_schema_seq, class: TableSchema do
    sequence(:table) {|n| "test_#{n}"}
    version       "trunk"
    owner         "sandbox"
    table_fields  {[FactoryGirl.build(:table_field_1),
                    FactoryGirl.build(:table_field_2)]}
  end

  factory :table_schema_online, class: TableSchema do
    table         "sites"
    version       "trunk"
    owner         "online"
    table_fields  {[FactoryGirl.build(:table_field_1),
                    FactoryGirl.build(:table_field_2)]}
  end
end
