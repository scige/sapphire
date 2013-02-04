require 'spec_helper'

describe TableSchema do
  describe "validate presence" do
    describe "when all field are present" do
      let(:ts) { FactoryGirl.build(:table_schema) }

      it "should have these field" do
        ts.should respond_to(:table)
        ts.should respond_to(:version)
        ts.should respond_to(:owner)
        ts.should respond_to(:table_fields)
      end

      it "should be valid" do
        ts.should be_valid
      end
    end

    describe "when table is not present" do
      let(:ts) { FactoryGirl.build(:table_schema, table: nil) }

      it "should not be valid" do
        ts.should_not be_valid
      end
    end

    describe "when table is null" do
      let(:ts) { FactoryGirl.build(:table_schema, table: "") }

      it "should not be valid" do
        ts.should_not be_valid
      end
    end

    describe "when version is not present" do
      let(:ts) { FactoryGirl.build(:table_schema, version: nil) }

      it "should not be valid" do
        ts.should_not be_valid
      end
    end

    describe "when version is null" do
      let(:ts) { FactoryGirl.build(:table_schema, version: "") }

      it "should not be valid" do
        ts.should_not be_valid
      end
    end

    describe "when owner is not present" do
      let(:ts) { FactoryGirl.build(:table_schema, owner: nil) }

      it "should not be valid" do
        ts.should_not be_valid
      end
    end

    describe "when owner is null" do
      let(:ts) { FactoryGirl.build(:table_schema, owner: "") }

      it "should not be valid" do
        ts.should_not be_valid
      end
    end

    describe "when table_fields is not present" do
      let(:ts) { FactoryGirl.build(:table_schema, table_fields: nil) }

      it "should not be valid" do
        ts.should_not be_valid
      end
    end

    describe "when table_fields is null" do
      let(:ts) { FactoryGirl.build(:table_schema, table_fields: []) }

      it "should not be valid" do
        ts.should_not be_valid
      end
    end
  end

  describe "when validate uniqueness" do
    let(:ts) { FactoryGirl.create(:table_schema) }
    let(:ts2) { FactoryGirl.build(:table_schema) }

    it "first model should be valid, second model should not be valid" do
      ts.should be_valid
      ts2.should_not be_valid
    end

    #binding.pry

    describe "test database_cleaner :each clean" do
      it "should be valid, because database_cleaner has executed" do
        ts2.should be_valid
      end
    end
  end

  describe "when use group_fields method" do
    let(:ts) { FactoryGirl.create(:table_schema) }
    let(:gfs) { ts.group_fields }

    it "should have key value hash" do
      gfs.should be_an_instance_of(Hash)
      gfs.should have_key("key")
      gfs.should have_key("value")
      gfs["key"].should have(1).table_fields
      gfs["key"].should == [FactoryGirl.build(:table_field_1, "_id"=>1)]
      gfs["value"].should have(1).table_fields
      gfs["value"].should == [FactoryGirl.build(:table_field_2, "_id"=>2)]
    end
  end

  describe "when use groups method" do
    let(:ts) { FactoryGirl.create(:table_schema) }
    let(:gs) { ts.groups }

    it "should have key value hash" do
      gs.should be_an_instance_of(Array)
      gs.should have(2).items
      gs[0].should == "key"
      gs[1].should == "value"
    end
  end
end
