require 'spec_helper'

describe "table_schemas/show" do
  before(:each) do
    @table_schema = assign(:table_schema, stub_model(TableSchema,
      :table => "Table",
      :version => 1,
      :owner => "Owner"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Table/)
    rendered.should match(/1/)
    rendered.should match(/Owner/)
  end
end
