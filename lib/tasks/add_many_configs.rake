namespace :db do
  desc "Add many recommend_configs to mongodb"
  task :addconfigs => :environment do
    100.times do |n|
      RecommendConfig.create!(
        {
          "table_schema_id"=>"1",
          "key"=>
            {"scope"=>Faker::Name.name,
             "scope_type"=>"domain",
             "domain"=>"meishichina.com"},
          "basic"=>
            {"source"=>"redis", "timeliness"=>"default"},
          "alg_1"=>
            {"fetch_count"=>"60", "enable"=>"true"}
        }
      )
    end
  end
end
