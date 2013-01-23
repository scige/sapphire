require "spec_helper"

describe TagTableSchemasController do
  describe "routing" do

    it "routes to #show" do
      get("/tag_table_schemas/1").should route_to("tag_table_schemas#show", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tag_table_schemas/1").should route_to("tag_table_schemas#destroy", :id => "1")
    end

    it "routes to #dump_xml" do
      post("/tag_table_schemas/dump_xml").should route_to("tag_table_schemas#dump_xml")
    end

  end
end
