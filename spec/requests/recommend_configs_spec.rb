#coding: utf-8

require 'spec_helper'

describe "RecommendConfigs" do

  subject{ page }

  describe "when click [Configurations] in homepage" do
    let!(:ts) {FactoryGirl.create(:table_schema_online)}
    before(:each) do
      visit root_path
      click_link "Configurations"
    end

    it "should have some content" do
      should have_link("New Config")                                 #link
      should have_link("sites")
      should have_selector("tr th", :text=>"id")                     #table
      should have_selector("tr th", :text=>"domain")
    end

    describe "when click [New Config]" do
      before(:each) do 
        click_link "New Config"
      end

      it "shoud have some content" do
        should have_content("New Config")
        should have_link("KEY GROUP")
        should have_selector("label", :text=>"Domain")
        should have_field("sites[key][domain]", :type=>"text")
        should have_link("VALUE GROUP")
        should have_selector("label", :text=>"Pattern")              #label
        should have_field("sites[value][pattern]", :type=>"text")    #input
        should have_button("Create Config")                          #submit
        should have_link("Back")
      end

      describe "when input new config" do
        before(:each) do
          fill_in "sites[key][domain]", :with=>"meishichina.com"
          fill_in "sites[value][pattern]", :with=>"http://home.meishichina.com/*/*.html"
        end

        it "should increase 1 RecommendConfig data" do
          expect {
            click_button "Create Config"
          }.to change(RecommendConfig, :count).by(1)
        end
      end

      describe "when input new config, then click [Back], return to index view" do
        before(:each) do
          fill_in "sites[key][domain]", :with=>"meishichina.com"
          fill_in "sites[value][pattern]", :with=>"http://home.meishichina.com/*/*.html"
          click_button "Create Config"
          click_link "Back"
        end

        it "should display 1 RecommendConfig data" do
          should have_link("New Config")
          should have_link("sites")
          should have_selector("tr td", :text=>"meishichina.com")
          should_not have_selector("tr td", :text=>"http://home.meishichina.com/*/*.html")
        end

        it "should decrease 1 RecommendConfig data" do
          expect {
            # 这里不会执行JS代码, 直接就提交了？
            click_link "Destroy"
          }.to change(RecommendConfig, :count).by(-1)
        end
      end
    end
  end
end
