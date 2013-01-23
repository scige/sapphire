require "spec_helper"

describe RecommendConfigsController do
  describe "routing" do

    it "routes to #index" do
      get("/recommend_configs").should route_to("recommend_configs#index")
    end

    it "routes to #new" do
      get("/recommend_configs/new").should route_to("recommend_configs#new")
    end

    it "routes to #show" do
      get("/recommend_configs/1").should route_to("recommend_configs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/recommend_configs/1/edit").should route_to("recommend_configs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/recommend_configs").should route_to("recommend_configs#create")
    end

    it "routes to #update" do
      put("/recommend_configs/1").should route_to("recommend_configs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/recommend_configs/1").should route_to("recommend_configs#destroy", :id => "1")
    end

  end
end
