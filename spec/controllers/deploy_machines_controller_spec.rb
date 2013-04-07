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

describe DeployMachinesController do

  # This should return the minimal set of attributes required to create a valid
  # DeployMachine. As you add validations to DeployMachine, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "name" => "MyString" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # DeployMachinesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all deploy_machines as @deploy_machines" do
      deploy_machine = DeployMachine.create! valid_attributes
      get :index, {}, valid_session
      assigns(:deploy_machines).should eq([deploy_machine])
    end
  end

  describe "GET show" do
    it "assigns the requested deploy_machine as @deploy_machine" do
      deploy_machine = DeployMachine.create! valid_attributes
      get :show, {:id => deploy_machine.to_param}, valid_session
      assigns(:deploy_machine).should eq(deploy_machine)
    end
  end

  describe "GET new" do
    it "assigns a new deploy_machine as @deploy_machine" do
      get :new, {}, valid_session
      assigns(:deploy_machine).should be_a_new(DeployMachine)
    end
  end

  describe "GET edit" do
    it "assigns the requested deploy_machine as @deploy_machine" do
      deploy_machine = DeployMachine.create! valid_attributes
      get :edit, {:id => deploy_machine.to_param}, valid_session
      assigns(:deploy_machine).should eq(deploy_machine)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new DeployMachine" do
        expect {
          post :create, {:deploy_machine => valid_attributes}, valid_session
        }.to change(DeployMachine, :count).by(1)
      end

      it "assigns a newly created deploy_machine as @deploy_machine" do
        post :create, {:deploy_machine => valid_attributes}, valid_session
        assigns(:deploy_machine).should be_a(DeployMachine)
        assigns(:deploy_machine).should be_persisted
      end

      it "redirects to the created deploy_machine" do
        post :create, {:deploy_machine => valid_attributes}, valid_session
        response.should redirect_to(DeployMachine.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved deploy_machine as @deploy_machine" do
        # Trigger the behavior that occurs when invalid params are submitted
        DeployMachine.any_instance.stub(:save).and_return(false)
        post :create, {:deploy_machine => { "name" => "invalid value" }}, valid_session
        assigns(:deploy_machine).should be_a_new(DeployMachine)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        DeployMachine.any_instance.stub(:save).and_return(false)
        post :create, {:deploy_machine => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested deploy_machine" do
        deploy_machine = DeployMachine.create! valid_attributes
        # Assuming there are no other deploy_machines in the database, this
        # specifies that the DeployMachine created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        DeployMachine.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
        put :update, {:id => deploy_machine.to_param, :deploy_machine => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested deploy_machine as @deploy_machine" do
        deploy_machine = DeployMachine.create! valid_attributes
        put :update, {:id => deploy_machine.to_param, :deploy_machine => valid_attributes}, valid_session
        assigns(:deploy_machine).should eq(deploy_machine)
      end

      it "redirects to the deploy_machine" do
        deploy_machine = DeployMachine.create! valid_attributes
        put :update, {:id => deploy_machine.to_param, :deploy_machine => valid_attributes}, valid_session
        response.should redirect_to(deploy_machine)
      end
    end

    describe "with invalid params" do
      it "assigns the deploy_machine as @deploy_machine" do
        deploy_machine = DeployMachine.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        DeployMachine.any_instance.stub(:save).and_return(false)
        put :update, {:id => deploy_machine.to_param, :deploy_machine => { "name" => "invalid value" }}, valid_session
        assigns(:deploy_machine).should eq(deploy_machine)
      end

      it "re-renders the 'edit' template" do
        deploy_machine = DeployMachine.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        DeployMachine.any_instance.stub(:save).and_return(false)
        put :update, {:id => deploy_machine.to_param, :deploy_machine => { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested deploy_machine" do
      deploy_machine = DeployMachine.create! valid_attributes
      expect {
        delete :destroy, {:id => deploy_machine.to_param}, valid_session
      }.to change(DeployMachine, :count).by(-1)
    end

    it "redirects to the deploy_machines list" do
      deploy_machine = DeployMachine.create! valid_attributes
      delete :destroy, {:id => deploy_machine.to_param}, valid_session
      response.should redirect_to(deploy_machines_url)
    end
  end

end