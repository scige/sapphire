FactoryGirl.define do
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

  factory :table_schema do
    table         "test"
    version       "trunk"
    owner         "sandbox"
    table_fields  {[FactoryGirl.build(:table_field_1),
                    FactoryGirl.build(:table_field_2)]}
  end

  factory :recommend_config do
    association   :table_schema
  end
end
