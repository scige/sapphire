require 'spec_helper'

describe RecommendConfig do
  describe "validate" do
    describe "table_schema_id is not present" do
      let(:rc) { FactoryGirl.build(:recommend_config) }

      it "should not vlid" do
        rc.should_not be_valid
      end
    end

    describe "table_schema_id is present" do
      let(:rc) { FactoryGirl.build(:recommend_config) }

      it "should valid" do
        rc.table_schema_id = 1
        rc.should be_valid
      end
    end

    describe "create recommend_config" do
      let(:rc) { FactoryGirl.create(:recommend_config, table_schema_id: 1) }

      binding.pry

      it "should valid" do
        rc.should be_valid
        rc_count = RecommendConfig.count
        rc_count.should == 1
      end
    end
  end
end
