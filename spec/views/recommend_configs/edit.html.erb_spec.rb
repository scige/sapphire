require 'spec_helper'

describe "recommend_configs/edit" do
  before(:each) do
    @recommend_config = assign(:recommend_config, stub_model(RecommendConfig))
  end

  it "renders the edit recommend_config form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recommend_configs_path(@recommend_config), :method => "post" do
    end
  end
end
