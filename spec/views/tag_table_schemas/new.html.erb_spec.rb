require 'spec_helper'

describe "tag_table_schemas/new" do
  before(:each) do
    assign(:tag_table_schema, stub_model(TagTableSchema).as_new_record)
  end

  it "renders new tag_table_schema form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tag_table_schemas_path, :method => "post" do
    end
  end
end
