require 'spec_helper'

describe TagTableSchema do
  describe "validate presence" do
    describe "when all field are present" do
      let(:ts) { FactoryGirl.build(:tag_table_schema) }

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
      let(:ts) { FactoryGirl.build(:tag_table_schema, table: nil) }

      it "should not be valid" do
        ts.should_not be_valid
      end
    end

    describe "when table is null" do
      let(:ts) { FactoryGirl.build(:tag_table_schema, table: "") }

      it "should not be valid" do
        ts.should_not be_valid
      end
    end

    describe "when version is not present" do
      let(:ts) { FactoryGirl.build(:tag_table_schema, version: nil) }

      it "should not be valid" do
        ts.should_not be_valid
      end
    end

    describe "when version is null" do
      let(:ts) { FactoryGirl.build(:tag_table_schema, version: "") }

      it "should not be valid" do
        ts.should_not be_valid
      end
    end

    describe "when owner is not present" do
      let(:ts) { FactoryGirl.build(:tag_table_schema, owner: nil) }

      it "should not be valid" do
        ts.should_not be_valid
      end
    end

    describe "when owner is null" do
      let(:ts) { FactoryGirl.build(:tag_table_schema, owner: "") }

      it "should not be valid" do
        ts.should_not be_valid
      end
    end

    describe "when table_fields is not present" do
      let(:ts) { FactoryGirl.build(:tag_table_schema, table_fields: nil) }

      it "should not be valid" do
        ts.should_not be_valid
      end
    end

    describe "when table_fields is null" do
      let(:ts) { FactoryGirl.build(:tag_table_schema, table_fields: []) }

      it "should not be valid" do
        ts.should_not be_valid
      end
    end
  end

  describe "when no validate uniqueness" do
    let(:ts) { FactoryGirl.create(:tag_table_schema) }
    let(:ts2) { FactoryGirl.build(:tag_table_schema) }

    it "first model should be valid, second model should not be valid" do
      ts.should be_valid
      ts2.should be_valid
    end
  end

  describe "when use groups method" do
    let(:ts) { FactoryGirl.create(:tag_table_schema) }
    let(:gs) { ts.groups }

    it "should have key value hash" do
      gs.should be_an_instance_of(Array)
      gs.should have(2).items
      gs[0].should == "key"
      gs[1].should == "value"
    end
  end

  describe "when clone_with_table_schema" do
    let(:ts) { FactoryGirl.create(:table_schema) }

    it "should have the same field as table_schema" do
      tag_ts = TagTableSchema.new
      tag_ts.clone_with_table_schema(ts)

      tag_ts.table.should == ts.table
      tag_ts.version.should == ts.version
      tag_ts.owner.should == ts.owner

      tfs_count = ts.table_fields.length
      tag_ts.should have(tfs_count).table_fields
      0.upto(tfs_count-1).each do |i|
        tag_ts.table_fields[i].should == ts.table_fields[i]
      end
    end
  end
end
