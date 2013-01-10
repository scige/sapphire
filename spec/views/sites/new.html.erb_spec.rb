require 'spec_helper'

describe "sites/new" do
  before(:each) do
    assign(:site, stub_model(Site,
      :scope => "MyString",
      :scope_type => "MyString",
      :domain => "MyString"
    ).as_new_record)
  end

  it "renders new site form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sites_path, :method => "post" do
      assert_select "input#site_scope", :name => "site[scope]"
      assert_select "input#site_scope_type", :name => "site[scope_type]"
      assert_select "input#site_domain", :name => "site[domain]"
    end
  end
end
