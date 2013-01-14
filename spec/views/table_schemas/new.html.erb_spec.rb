require 'spec_helper'

describe "table_schemas/new" do
  before(:each) do
    assign(:table_schema, stub_model(TableSchema,
      :table => "MyString",
      :version => 1,
      :owner => "MyString"
    ).as_new_record)
  end

  it "renders new table_schema form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => table_schemas_path, :method => "post" do
      assert_select "input#table_schema_table", :name => "table_schema[table]"
      assert_select "input#table_schema_version", :name => "table_schema[version]"
      assert_select "input#table_schema_owner", :name => "table_schema[owner]"
    end
  end
end
