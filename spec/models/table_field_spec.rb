require 'spec_helper'

describe TableField do
  describe "validate presence" do
    describe "when all field are present" do
      let(:tf) { FactoryGirl.build(:table_field) }

      it "should have these field" do
        tf.should respond_to(:group)
        tf.should respond_to(:label)
        tf.should respond_to(:name)
        tf.should respond_to(:default_value)
        tf.should respond_to(:help_text)
        tf.should respond_to(:field_type)
        tf.should respond_to(:option_value)
      end

      it "should be valid" do
        tf.should be_valid
      end
    end

    describe "when group is not present" do
      let(:tf) { FactoryGirl.build(:table_field, group: nil) }

      it "should not be valid" do
        tf.should_not be_valid
      end
    end

    describe "when group is null" do
      let(:tf) { FactoryGirl.build(:table_field, group: "") }

      it "should not be valid" do
        tf.should_not be_valid
      end
    end

    describe "when label is not present" do
      let(:tf) { FactoryGirl.build(:table_field, label: nil) }

      it "should not be valid" do
        tf.should_not be_valid
      end
    end

    describe "when label is null" do
      let(:tf) { FactoryGirl.build(:table_field, label: "") }

      it "should not be valid" do
        tf.should_not be_valid
      end
    end

    describe "when name is not present" do
      let(:tf) { FactoryGirl.build(:table_field, name: nil) }

      it "should not be valid" do
        tf.should_not be_valid
      end
    end

    describe "when name is null" do
      let(:tf) { FactoryGirl.build(:table_field, name: "") }

      it "should not be valid" do
        tf.should_not be_valid
      end
    end

    describe "when default_value is not present" do
      let(:tf) { FactoryGirl.build(:table_field, default_value: nil) }

      it "should be valid" do
        tf.should be_valid
      end
    end

    describe "when default_value is null" do
      let(:tf) { FactoryGirl.build(:table_field, default_value: "") }

      it "should be valid" do
        tf.should be_valid
      end
    end
  end
end
