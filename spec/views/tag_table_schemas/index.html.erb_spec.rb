require 'spec_helper'

describe "tag_table_schemas/index" do
  before(:each) do
    assign(:tag_table_schemas, [
      stub_model(TagTableSchema),
      stub_model(TagTableSchema)
    ])
  end

  it "renders a list of tag_table_schemas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
