require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the RecommendConfigsHelper. For example:
#
# describe RecommendConfigsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe RecommendConfigsHelper do
  describe "when normal string" do
    it "should have 3 option" do
      option_string = "online,offline,flow"
      option_array  = helper.get_options(option_string)
      option_array.should have(3).items
    end

    it "should have 1 option" do
      option_string = "online"
      option_array  = helper.get_options(option_string)
      option_array.should have(1).items
    end
  end

  describe "when exception string" do
    it "should have 2 option" do
      option_string = "   online,   offline  "
      option_array  = helper.get_options(option_string)
      option_array.should have(2).items
    end

    it "should have 3 option" do
      option_string = "   online, ,  offline  "
      option_array  = helper.get_options(option_string)
      option_array.should have(3).items
      option_array[1].should == ["",""]
    end

    it "should have 2 option" do
      option_string = "   online, "
      option_array  = helper.get_options(option_string)
      option_array.should have(2).items
      option_array[1].should == ["",""]
    end

    it "should have 2 option" do
      option_string = ",   online"
      option_array  = helper.get_options(option_string)
      option_array.should have(2).items
      option_array[0].should == ["",""]
    end
  end
end
