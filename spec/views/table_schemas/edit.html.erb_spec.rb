require 'spec_helper'

describe "table_schemas/edit" do
  before(:each) do
    @table_schema = assign(:table_schema, stub_model(TableSchema,
      :table => "MyString",
      :version => 1,
      :owner => "MyString"
    ))
  end

  it "renders the edit table_schema form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => table_schemas_path(@table_schema), :method => "post" do
      assert_select "input#table_schema_table", :name => "table_schema[table]"
      assert_select "input#table_schema_version", :name => "table_schema[version]"
      assert_select "select#table_schema_owner", :name => "table_schema[owner]"
    end
  end
end
