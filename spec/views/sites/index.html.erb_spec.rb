require 'spec_helper'

describe "sites/index" do
  before(:each) do
    assign(:sites, [
      stub_model(Site,
        :scope => "Scope",
        :scope_type => "Scope Type",
        :domain => "Domain"
      ),
      stub_model(Site,
        :scope => "Scope",
        :scope_type => "Scope Type",
        :domain => "Domain"
      )
    ])
  end

  it "renders a list of sites" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Scope".to_s, :count => 2
    assert_select "tr>td", :text => "Scope Type".to_s, :count => 2
    assert_select "tr>td", :text => "Domain".to_s, :count => 2
  end
end
