require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the TableSchemasHelper. For example:
#
# describe TableSchemasHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe TableSchemasHelper do
  describe "when create 5 table_schemas" do
    before(:each) do
      FactoryGirl.reload
      FactoryGirl.create_list(:table_schema_seq, 5)
    end

    describe "when call get_owner_first_table method" do
      it "should be test_1" do
        table = helper.get_owner_first_table("sandbox")
        table.should == "test_1"
      end
    end

    describe "when call get_owner_all_tables" do
      it "should have 5 table_schemas" do
        table_schemas = helper.get_owner_all_tables("sandbox")
        table_schemas.should have(5).table_schemas
      end
    end

    describe "when owner have no table" do
      it "should be nil" do
        table = helper.get_owner_first_table("online")
        table.should == nil
      end
    end

    describe "when owner have no table" do
      it "should have 0 table_schemas" do
        table_schemas = helper.get_owner_all_tables("online")
        table_schemas.should have(0).table_schemas
      end
    end
  end

  describe "when have no table_schemas" do
    before(:each) do
      FactoryGirl.reload
    end

    describe "when call get_owner_first_table method" do
      it "should be nil" do
        table = helper.get_owner_first_table("sandbox")
        table.should == nil
      end
    end
  end
end
