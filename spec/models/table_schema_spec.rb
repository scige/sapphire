require 'spec_helper'

describe TableSchema do
  describe "validate presence" do
    describe "all field are present" do
      let(:ts) {FactoryGirl.build(:table_schema)}

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

    describe "table is not present" do
      let(:ts) {FactoryGirl.build(:table_schema, table: nil)}

      it "should not be valid" do
        ts.should_not be_valid
      end
    end

    describe "table is null" do
      let(:ts) {FactoryGirl.build(:table_schema, table: "")}

      it "should not be valid" do
        ts.should_not be_valid
      end
    end

    describe "version is not present" do
      let(:ts) {FactoryGirl.build(:table_schema, version: nil)}

      it "should not be valid" do
        ts.should_not be_valid
      end
    end

    describe "version is null" do
      let(:ts) {FactoryGirl.build(:table_schema, version: "")}

      it "should not be valid" do
        ts.should_not be_valid
      end
    end

    describe "owner is not present" do
      let(:ts) {FactoryGirl.build(:table_schema, owner: nil)}

      it "should not be valid" do
        ts.should_not be_valid
      end
    end

    describe "owner is null" do
      let(:ts) {FactoryGirl.build(:table_schema, owner: "")}

      it "should not be valid" do
        ts.should_not be_valid
      end
    end

    describe "table_fields is not present" do
      let(:ts) {FactoryGirl.build(:table_schema, table_fields: nil)}

      it "should not be valid" do
        ts.should_not be_valid
      end
    end

    describe "table_fields is null" do
      let(:ts) {FactoryGirl.build(:table_schema, table_fields: [])}

      it "should not be valid" do
        ts.should_not be_valid
      end
    end
  end

  describe "validate uniqueness" do
    let(:ts) {FactoryGirl.create(:table_schema)}

    it "first model should be valid" do
      ts.should be_valid
    end

    #binding.pry

    let(:ts2) {FactoryGirl.build(:table_schema)}

    it "second model should not be valid" do
      ts2.should_not be_valid
    end
  end
end
