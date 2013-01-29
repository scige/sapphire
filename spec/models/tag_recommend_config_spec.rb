require 'spec_helper'

describe RecommendConfig do
  describe "validate" do
    describe "when tag_table_schema_id is not present" do
      let(:rc) { FactoryGirl.build(:tag_recommend_config) }

      it "should not vlid" do
        rc.tag_table_schema = nil
        rc.should_not be_valid
      end
    end

    describe "when tag_table_schema_id is present" do
      let(:rc) { FactoryGirl.build(:tag_recommend_config) }

      it "should valid" do
        rc.should be_valid
      end
    end

    describe "when create recommend_config" do
      let(:rc) { FactoryGirl.create(:tag_recommend_config) }

      it "should valid" do
        rc.should be_valid
        rc_count = TagRecommendConfig.count
        rc_count.should == 1
      end
    end
  end
end

