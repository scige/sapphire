require 'spec_helper'

describe RecommendConfig do
  describe "validate" do
    describe "table_schema_id is not present" do
      let(:rc) { FactoryGirl.build(:recommend_config) }

      it "should not vlid" do
        rc.table_schema = nil
        rc.should_not be_valid
      end
    end

    describe "table_schema_id is present" do
      let(:rc) { FactoryGirl.build(:recommend_config) }

      it "should valid" do
        rc.should be_valid
      end
    end

    describe "create recommend_config" do
      let(:rc) { FactoryGirl.create(:recommend_config) }

      it "should valid" do
        rc.should be_valid
        rc_count = RecommendConfig.count
        rc_count.should == 1
      end
    end
  end

  describe "let is lazy-evaluated" do
    #let(:rc) { FactoryGirl.create(:recommend_config) }
    let!(:rc) { FactoryGirl.create(:recommend_config) }

    it "should have 1 recommend_config" do
      rc_count = RecommendConfig.count
      rc_count.should == 1
    end
  end

  describe "association" do
    let!(:ts) { FactoryGirl.create(:table_schema) }
    let!(:rc1) { FactoryGirl.create(:recommend_config, :table_schema => ts) }
    let!(:rc2) { FactoryGirl.create(:recommend_config, :table_schema => ts) }
    let!(:rc3) { FactoryGirl.create(:recommend_config, :table_schema => ts) }

    it "table_schema should has 3 recommend_configs" do
      rc_count = RecommendConfig.count
      rc_count.should == 3
      #binding.pry
      pending "association case hasn't pass. #{__FILE__}"
      ts.recommend_configs.length.should == 3
    end
  end
end
