require 'spec_helper'

describe "tag_table_schemas/show" do
  before(:each) do
    @tag_table_schema = assign(:tag_table_schema, stub_model(TagTableSchema))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
