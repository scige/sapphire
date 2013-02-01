FactoryGirl.define do
  factory :tag_table_field_1, class: TableField do
    group   "key"
    name    "domain"
    label   "domain"
  end

  factory :tag_table_field_2, class: TableField do
    group   "value"
    name    "pattern"
    label   "pattern"
  end

  factory :tag_table_schema do
    table         "test"
    version       "trunk"
    owner         "sandbox"
    table_fields  {[FactoryGirl.build(:tag_table_field_1),
                    FactoryGirl.build(:tag_table_field_2)]}
  end

  factory :tag_recommend_config do
    association   :tag_table_schema
  end
end
