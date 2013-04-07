# coding: utf-8

class DeployMachinesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @deploy_machines = DeployMachine.order_by([[:id, :asc]])
  end

  def show
    @deploy_machine = DeployMachine.find(params[:id])
  end

  def new
    @deploy_machine = DeployMachine.new
  end

  def edit
    @deploy_machine = DeployMachine.find(params[:id])
  end

  def create
    @deploy_machine = DeployMachine.new(params[:deploy_machine])

    if @deploy_machine.save
      redirect_to @deploy_machine, notice: 'Deploy machine was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @deploy_machine = DeployMachine.find(params[:id])

    if @deploy_machine.update_attributes(params[:deploy_machine])
      redirect_to @deploy_machine, notice: 'Deploy machine was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @deploy_machine = DeployMachine.find(params[:id])
    @deploy_machine.destroy

    redirect_to deploy_machines_url
  end
end
