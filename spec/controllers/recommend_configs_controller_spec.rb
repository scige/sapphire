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

describe RecommendConfigsController do

  # This should return the minimal set of attributes required to create a valid
  # RecommendConfig. As you add validations to RecommendConfig, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {
      "table_schema_id"=>1,
      "key"=>
      {
        "domain"=>"meishichina.com"
      },
      "value"=>
      {
        "pattern"=>"http://home.meishichina.com/*/*.html"
      }
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # RecommendConfigsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  before(:each) do
    FactoryGirl.create(:table_schema)
  end

  describe "GET index" do
    it "assigns all recommend_configs as @recommend_configs" do
      recommend_config = RecommendConfig.create! valid_attributes
      get :index, {:table => "test"}, valid_session
      assigns(:recommend_configs).should eq([recommend_config])
    end
  end

  describe "GET show" do
    it "assigns the requested recommend_config as @recommend_config" do
      recommend_config = RecommendConfig.create! valid_attributes
      get :show, {:id => recommend_config.to_param, :table => "test"}, valid_session
      assigns(:recommend_config).should eq(recommend_config)
    end
  end

  describe "GET new" do
    it "assigns a new recommend_config as @recommend_config" do
      get :new, {:table => "test"}, valid_session
      assigns(:recommend_config).should be_a_new(RecommendConfig)
    end
  end

  describe "GET edit" do
    it "assigns the requested recommend_config as @recommend_config" do
      recommend_config = RecommendConfig.create! valid_attributes
      get :edit, {:id => recommend_config.to_param, :table => "test"}, valid_session
      assigns(:recommend_config).should eq(recommend_config)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new RecommendConfig" do
        expect {
          post :create, {:test => valid_attributes, :table=>"test"}, valid_session
        }.to change(RecommendConfig, :count).by(1)
      end

      it "assigns a newly created recommend_config as @recommend_config" do
        post :create, {:test => valid_attributes, :table=>"test"}, valid_session
        assigns(:recommend_config).should be_a(RecommendConfig)
        assigns(:recommend_config).should be_persisted
      end

      it "redirects to the created recommend_config" do
        binding.pry
        post :create, {:test => valid_attributes, :table=>"test"}, valid_session
        response.should redirect_to(recommend_config_url(RecommendConfig.last, :table=>"test"))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved recommend_config as @recommend_config" do
        # Trigger the behavior that occurs when invalid params are submitted
        RecommendConfig.any_instance.stub(:save).and_return(false)
        post :create, {:test => {  }, :table=>"test"}, valid_session
        assigns(:recommend_config).should be_a_new(RecommendConfig)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        RecommendConfig.any_instance.stub(:save).and_return(false)
        post :create, {:test => {  }, :table=>"test"}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested recommend_config" do
        recommend_config = RecommendConfig.create! valid_attributes
        # Assuming there are no other recommend_configs in the database, this
        # specifies that the RecommendConfig created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        RecommendConfig.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, {:id => recommend_config.to_param, :test => valid_attributes, :table=>"test"}, valid_session
      end

      it "assigns the requested recommend_config as @recommend_config" do
        recommend_config = RecommendConfig.create! valid_attributes
        put :update, {:id => recommend_config.to_param, :test => valid_attributes, :table=>"test"}, valid_session
        assigns(:recommend_config).should eq(recommend_config)
      end

      it "redirects to the recommend_config" do
        recommend_config = RecommendConfig.create! valid_attributes
        put :update, {:id => recommend_config.to_param, :test => valid_attributes, :table=>"test"}, valid_session
        response.should redirect_to(recommend_config)
      end
    end

    describe "with invalid params" do
      it "assigns the recommend_config as @recommend_config" do
        recommend_config = RecommendConfig.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        RecommendConfig.any_instance.stub(:save).and_return(false)
        put :update, {:id => recommend_config.to_param, :test => {  }, :table=>"test"}, valid_session
        assigns(:recommend_config).should eq(recommend_config)
      end

      it "re-renders the 'edit' template" do
        recommend_config = RecommendConfig.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        RecommendConfig.any_instance.stub(:save).and_return(false)
        put :update, {:id => recommend_config.to_param, :test => {  }, :table=>"test"}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested recommend_config" do
      recommend_config = RecommendConfig.create! valid_attributes
      expect {
        delete :destroy, {:id => recommend_config.to_param}, valid_session
      }.to change(RecommendConfig, :count).by(-1)
    end

    it "redirects to the recommend_configs list" do
      recommend_config = RecommendConfig.create! valid_attributes
      delete :destroy, {:id => recommend_config.to_param}, valid_session
      response.should redirect_to(recommend_configs_url)
    end
  end

end
