# coding: utf-8

class AutoDeployController < ApplicationController
  def index
    @deploy_machines = DeployMachine.order_by([[:id, :asc]])
  end

  def deploy
    deploy_datum_id = session[:deploy_datum_id]
    @deploy_datum = DeployDatum.find(deploy_datum_id)
    deploy_machine_id = params[:machine]
    @deploy_machine = DeployMachine.find(deploy_machine_id)
    post_data = {}
    post_data[Setting.protocol.username.key] = Setting.protocol.username.value
    post_data[Setting.protocol.password.key] = Setting.protocol.password.value
    post_data[Setting.protocol.command.key] = Setting.protocol.command.reload
    post_data[Setting.protocol.host] = @deploy_machine.host
    post_data[Setting.protocol.directory] = @deploy_machine.directory
    post_data[Setting.protocol.config.key] = Setting.protocol.config.value
    #增加package参数

    @response = RestClient.post @deploy_machine.agent, post_data, :timeout=>30, :open_timeout=>30

    respond_to do |format|
      #format.html
      format.js {render :layout => false}
    end
  end

  def rollback
    deploy_machine_id = params[:machine]
    @deploy_machine = DeployMachine.find(deploy_machine_id)
    post_data = {}
    post_data[Setting.protocol.username.key] = Setting.protocol.username.value
    post_data[Setting.protocol.password.key] = Setting.protocol.password.value
    post_data[Setting.protocol.command.key] = Setting.protocol.command.rollback
    post_data[Setting.protocol.host] = @deploy_machine.host
    post_data[Setting.protocol.directory] = @deploy_machine.directory

    @response = RestClient.post @deploy_machine.agent, post_data, :timeout=>30, :open_timeout=>30

    respond_to do |format|
      #format.html
      format.js {render :layout => false}
    end
  end

  def finish
    deploy_datum_id = session[:deploy_datum_id]
    @deploy_datum = DeployDatum.find(deploy_datum_id)
    @deploy_machines = DeployMachine.order_by([[:id, :asc]])

    @deploy_datum.update_attributes(:status=>Setting.deploy_datum_status.Finish)
    session[:deploy_datum_id] = nil
  end
end
