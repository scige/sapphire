require 'spec_helper'

describe "table_schemas/index" do
  before(:each) do
    assign(:table_schemas, [
      stub_model(TableSchema,
        :table => "Table",
        :version => 1,
        :owner => "Owner"
      ),
      stub_model(TableSchema,
        :table => "Table",
        :version => 1,
        :owner => "Owner"
      )
    ])
  end

  it "renders a list of table_schemas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Table".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Owner".to_s, :count => 2
  end
end
