require 'spec_helper'

describe "recommend_configs/new" do
  before(:each) do
    assign(:recommend_config, stub_model(RecommendConfig).as_new_record)
  end

  it "renders new recommend_config form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recommend_configs_path, :method => "post" do
    end
  end
end
