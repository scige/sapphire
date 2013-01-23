require "spec_helper"

describe TableSchemasController do
  describe "routing" do

    it "routes to #index" do
      get("/table_schemas").should route_to("table_schemas#index")
    end

    it "routes to #new" do
      get("/table_schemas/new").should route_to("table_schemas#new")
    end

    it "routes to #show" do
      get("/table_schemas/1").should route_to("table_schemas#show", :id => "1")
    end

    it "routes to #edit" do
      get("/table_schemas/1/edit").should route_to("table_schemas#edit", :id => "1")
    end

    it "routes to #create" do
      post("/table_schemas").should route_to("table_schemas#create")
    end

    it "routes to #update" do
      put("/table_schemas/1").should route_to("table_schemas#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/table_schemas/1").should route_to("table_schemas#destroy", :id => "1")
    end

    it "routes to #create_tag" do
      post("/table_schemas/create_tag").should route_to("table_schemas#create_tag")
    end

  end
end
