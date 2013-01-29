require 'spec_helper'

describe TableField do
  describe "validate presence" do
    before(:each) do
      @tf = FactoryGirl.build(:table_field)
    end

    describe "when all field are present" do
      it "should have these field" do
        @tf.should respond_to(:group)
        @tf.should respond_to(:label)
        @tf.should respond_to(:name)
        @tf.should respond_to(:default_value)
        @tf.should respond_to(:help_text)
        @tf.should respond_to(:field_type)
        @tf.should respond_to(:option_value)
      end

      it "should be valid" do
        @tf.should be_valid
      end
    end

    describe "when group is not present" do
      it "should not be valid" do
        @tf.group = nil
        @tf.should_not be_valid
      end
    end

    describe "when group is null" do
      it "should not be valid" do
        @tf.group = ""
        @tf.should_not be_valid
      end
    end

    describe "when label is not present" do
      it "should not be valid" do
        @tf.label = nil
        @tf.should_not be_valid
      end
    end

    describe "when label is null" do
      it "should not be valid" do
        @tf.label = ""
        @tf.should_not be_valid
      end
    end

    describe "when name is not present" do
      it "should not be valid" do
        @tf.name = nil
        @tf.should_not be_valid
      end
    end

    describe "when name is null" do
      it "should not be valid" do
        @tf.name = ""
        @tf.should_not be_valid
      end
    end

    describe "when default_value is not present" do
      it "should be valid" do
        @tf.default_value = nil
        @tf.should be_valid
      end
    end

    describe "when default_value is null" do
      it "should be valid" do
        @tf.default_value = ""
        @tf.should be_valid
      end
    end
  end
end
