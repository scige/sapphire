require 'spec_helper'

describe ApplicationController do

  describe "when call clone_attributes method" do
    describe "when recommend_config is corresponding to table_schema" do
      let!(:ts) {FactoryGirl.create(:table_schema)}
      let!(:rc) {FactoryGirl.create(:recommend_config, :table_schema => ts)}

      it "should have 2 group" do
        rc[:key] = {:domain=>"meishichina.com"}
        rc[:value] = {:pattern=>"http://home.meishichina.com/*/*.html"}
        rc_clone = controller.send(:clone_attributes, rc, ts)
        rc_clone.should have(2).items
      end
    end

    describe "when recommend_config has more group than table_schema" do
      let!(:ts) {FactoryGirl.create(:table_schema)}
      let!(:rc) {FactoryGirl.create(:recommend_config, :table_schema => ts)}

      it "should be nil" do
        rc[:key] = {:domain=>"meishichina.com"}
        rc[:value] = {:pattern=>"http://home.meishichina.com/*/*.html"}
        rc[:other] = {:description=>"meishichina.com"}
        rc_clone = controller.send(:clone_attributes, rc, ts)
        rc_clone.should == nil
      end
    end

    describe "when recommend_config has different group from table_schema" do
      let!(:ts) {FactoryGirl.create(:table_schema)}
      let!(:rc) {FactoryGirl.create(:recommend_config, :table_schema => ts)}

      it "should be nil" do
        rc[:key] = {:domain=>"meishichina.com"}
        rc[:other] = {:description=>"meishichina.com"}
        rc_clone = controller.send(:clone_attributes, rc, ts)
        rc_clone.should == nil
      end
    end
  end

end
