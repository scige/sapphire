require 'spec_helper'

describe "recommend_configs/index" do
  before(:each) do
    assign(:recommend_configs, [
      stub_model(RecommendConfig),
      stub_model(RecommendConfig)
    ])
  end

  it "renders a list of recommend_configs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
