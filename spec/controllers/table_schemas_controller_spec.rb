require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe TableSchemasController do

  # This should return the minimal set of attributes required to create a valid
  # TableSchema. As you add validations to TableSchema, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {
      "table" => "mytable",
      "version" => "trunk",
      "owner" => "sandbox",
      "table_fields_attributes"=>
      {
        "1359542151595"=>
        {"group"=>"key",
         "label"=>"domain",
         "name"=>"domain",
         "field_type"=>"input"},
        "1359542161209"=>
        {"group"=>"value",
         "label"=>"pattern",
         "name"=>"pattern",
         "field_type"=>"input"}
      }
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TableSchemasController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all table_schemas as @table_schemas" do
      table_schema = TableSchema.create! valid_attributes
      get :index, {}, valid_session
      assigns(:table_schemas).should eq([table_schema])
    end
  end

  describe "GET show" do
    it "assigns the requested table_schema as @table_schema" do
      table_schema = TableSchema.create! valid_attributes
      get :show, {:id => table_schema.to_param}, valid_session
      assigns(:table_schema).should eq(table_schema)
    end
  end

  describe "GET new" do
    it "assigns a new table_schema as @table_schema" do
      get :new, {}, valid_session
      assigns(:table_schema).should be_a_new(TableSchema)
    end
  end

  describe "GET edit" do
    it "assigns the requested table_schema as @table_schema" do
      table_schema = TableSchema.create! valid_attributes
      get :edit, {:id => table_schema.to_param}, valid_session
      assigns(:table_schema).should eq(table_schema)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new TableSchema" do
        expect {
          post :create, {:table_schema => valid_attributes}, valid_session
        }.to change(TableSchema, :count).by(1)
      end

      it "assigns a newly created table_schema as @table_schema" do
        post :create, {:table_schema => valid_attributes}, valid_session
        assigns(:table_schema).should be_a(TableSchema)
        assigns(:table_schema).should be_persisted
      end

      it "redirects to the created table_schema" do
        post :create, {:table_schema => valid_attributes}, valid_session
        response.should redirect_to(TableSchema.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved table_schema as @table_schema" do
        # Trigger the behavior that occurs when invalid params are submitted
        TableSchema.any_instance.stub(:save).and_return(false)
        post :create, {:table_schema => { "table" => "invalid value" }}, valid_session
        assigns(:table_schema).should be_a_new(TableSchema)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        TableSchema.any_instance.stub(:save).and_return(false)
        post :create, {:table_schema => { "table" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested table_schema" do
        table_schema = TableSchema.create! valid_attributes
        # Assuming there are no other table_schemas in the database, this
        # specifies that the TableSchema created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        TableSchema.any_instance.should_receive(:update_attributes).with({ "table" => "MyString" })
        put :update, {:id => table_schema.to_param, :table_schema => { "table" => "MyString" }}, valid_session
      end

      it "assigns the requested table_schema as @table_schema" do
        table_schema = TableSchema.create! valid_attributes
        put :update, {:id => table_schema.to_param, :table_schema => valid_attributes}, valid_session
        assigns(:table_schema).should eq(table_schema)
      end

      it "redirects to the table_schema" do
        table_schema = TableSchema.create! valid_attributes
        put :update, {:id => table_schema.to_param, :table_schema => valid_attributes}, valid_session
        response.should redirect_to(table_schema)
      end
    end

    describe "with invalid params" do
      it "assigns the table_schema as @table_schema" do
        table_schema = TableSchema.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        TableSchema.any_instance.stub(:save).and_return(false)
        put :update, {:id => table_schema.to_param, :table_schema => { "table" => "invalid value" }}, valid_session
        assigns(:table_schema).should eq(table_schema)
      end

      it "re-renders the 'edit' template" do
        table_schema = TableSchema.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        TableSchema.any_instance.stub(:save).and_return(false)
        put :update, {:id => table_schema.to_param, :table_schema => { "table" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested table_schema" do
      table_schema = TableSchema.create! valid_attributes
      expect {
        delete :destroy, {:id => table_schema.to_param}, valid_session
      }.to change(TableSchema, :count).by(-1)
    end

    it "redirects to the table_schemas list" do
      table_schema = TableSchema.create! valid_attributes
      delete :destroy, {:id => table_schema.to_param}, valid_session
      response.should redirect_to(table_schemas_url)
    end
  end

  describe "when call get_diff_fields method" do

    before(:each) do
      @table_schema_old = FactoryGirl.create(:table_schema)
      @table_schema_new = @table_schema_old.dup
    end

    describe "when no modify" do
      it "should return default hash" do
        diff_fields = controller.send(:get_diff_fields, 
                                      @table_schema_old.table_fields,
                                      @table_schema_new.table_fields)
        diff_fields.should == {:add=>[], :remove=>[], :modify=>[]}
      end
    end

    describe "when add field" do
      it "should have add field" do
        @table_schema_new.table_fields << FactoryGirl.build(:table_field_3)
        @table_schema_new.save
        diff_fields = controller.send(:get_diff_fields, 
                                      @table_schema_old.table_fields,
                                      @table_schema_new.table_fields)
        diff_fields[:add].should have(1).items
      end
    end

    describe "when remove field" do
      it "should have remove field" do
        @table_schema_new.table_fields.delete_if {|f| f.name == "pattern"}
        @table_schema_new.save
        diff_fields = controller.send(:get_diff_fields, 
                                      @table_schema_old.table_fields,
                                      @table_schema_new.table_fields)
        diff_fields[:remove].should have(1).items
      end
    end

    describe "when modify field's group" do
      it "should be nil" do
        @table_schema_new.table_fields[1]["group"] = "new_value"
        @table_schema_new.save
        diff_fields = controller.send(:get_diff_fields, 
                                      @table_schema_old.table_fields,
                                      @table_schema_new.table_fields)
        diff_fields.should == nil
      end
    end

    describe "when modify field's label" do
      it "should not have modify field" do
        @table_schema_new.table_fields[1]["label"] = "new_pattern"
        @table_schema_new.save
        diff_fields = controller.send(:get_diff_fields, 
                                      @table_schema_old.table_fields,
                                      @table_schema_new.table_fields)
        diff_fields.should == {:add=>[], :remove=>[], :modify=>[]}
      end
    end

    describe "when modify field's name" do
      it "should have modify field" do
        @table_schema_new.table_fields[1]["name"] = "new_pattern"
        @table_schema_new.save
        diff_fields = controller.send(:get_diff_fields, 
                                      @table_schema_old.table_fields,
                                      @table_schema_new.table_fields)
        diff_fields[:modify].should have(1).items
      end
    end

    describe "when modify field's defalut_value" do
      it "should have modify field" do
        @table_schema_new.table_fields[1]["default_value"] = "http://abc.com/*/*.html"
        @table_schema_new.save
        diff_fields = controller.send(:get_diff_fields, 
                                      @table_schema_old.table_fields,
                                      @table_schema_new.table_fields)
        diff_fields[:modify].should have(1).items
      end
    end

    describe "when remove, add, modify fields" do
      it "should have remove, add, modify field" do
        @table_schema_new.table_fields.delete_if {|f| f.name == "pattern"}
        @table_schema_new.table_fields << FactoryGirl.build(:table_field_3)
        @table_schema_new.table_fields[0]["name"] = "new_domain"
        @table_schema_new.save
        diff_fields = controller.send(:get_diff_fields, 
                                      @table_schema_old.table_fields,
                                      @table_schema_new.table_fields)
        diff_fields[:remove].should have(1).items
        diff_fields[:add].should have(1).items
        diff_fields[:modify].should have(1).items
      end
    end
  end
end
