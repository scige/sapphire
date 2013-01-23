require 'spec_helper'

describe "tag_table_schemas/edit" do
  before(:each) do
    @tag_table_schema = assign(:tag_table_schema, stub_model(TagTableSchema))
  end

  it "renders the edit tag_table_schema form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tag_table_schemas_path(@tag_table_schema), :method => "post" do
    end
  end
end
