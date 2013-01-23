require 'spec_helper'

describe "recommend_configs/show" do
  before(:each) do
    @recommend_config = assign(:recommend_config, stub_model(RecommendConfig))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
