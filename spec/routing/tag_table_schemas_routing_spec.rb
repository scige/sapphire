require "spec_helper"

describe TagTableSchemasController do
  describe "routing" do

    it "routes to #index" do
      get("/tag_table_schemas").should route_to("tag_table_schemas#index")
    end

    it "routes to #new" do
      get("/tag_table_schemas/new").should route_to("tag_table_schemas#new")
    end

    it "routes to #show" do
      get("/tag_table_schemas/1").should route_to("tag_table_schemas#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tag_table_schemas/1/edit").should route_to("tag_table_schemas#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tag_table_schemas").should route_to("tag_table_schemas#create")
    end

    it "routes to #update" do
      put("/tag_table_schemas/1").should route_to("tag_table_schemas#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tag_table_schemas/1").should route_to("tag_table_schemas#destroy", :id => "1")
    end

  end
end
