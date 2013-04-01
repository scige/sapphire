# coding: utf-8
require 'xmlsimple'

class AutoDeployController < ApplicationController
  before_filter :necessary_conditions

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
    post_data[Setting.protocol.command.key] = Setting.protocol.command.deploy
    post_data[Setting.protocol.host] = @deploy_machine.host
    post_data[Setting.protocol.directory] = @deploy_machine.directory
    post_data[Setting.protocol.config.key] = Setting.protocol.config.value
    #增加package参数

    @deploy_machine.update_attributes(:status=>Setting.deploy_machine_status.running)
    response = RestClient.post @deploy_machine.agent, post_data, :timeout=>30, :open_timeout=>30
    @response_status, @response_detail = parse_response(response)
    if @response_status == Setting.deploy_machine_status.deploy_success
      @deploy_machine.update_attributes(:status=>Setting.deploy_machine_status.deploy_success)
    else
      @respons_status = Setting.deploy_machine_status.deploy_failed
      @deploy_machine.update_attributes(:status=>Setting.deploy_machine_status.deploy_failed)
    end

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

    @deploy_machine.update_attributes(:status=>Setting.deploy_machine_status.running)
    response = RestClient.post @deploy_machine.agent, post_data, :timeout=>30, :open_timeout=>30
    @response_status, @response_detail = parse_response(response)
    if @response_status == Setting.deploy_machine_status.rollback_success
      @deploy_machine.update_attributes(:status=>Setting.deploy_machine_status.rollback_success)
    else
      @response_status = Setting.deploy_machine_status.rollback_failed
      @deploy_machine.update_attributes(:status=>Setting.deploy_machine_status.rollback_failed)
    end

    respond_to do |format|
      #format.html
      format.js {render :layout => false}
    end
  end

  def finish
    deploy_machines = DeployMachine.order_by([[:id, :asc]])
    is_all_success = true
    deploy_machines.each do |machine|
      if machine.status != Setting.deploy_machine_status.deploy_success
        is_all_success = false
        break
      end
    end

    @deploy_machines = []
    if is_all_success
      #只有全部机器成功才会自动修改状态，为了view显示本次上线结果
      deploy_machines.each do |machine|
        @deploy_machines << machine.dup
        machine.update_attributes(:status=>Setting.deploy_machine_status.active)
      end
    else
      @deploy_machines = deploy_machines
    end

    #@deploy_machines = DeployMachine.order_by([[:id, :asc]])

    deploy_datum_id = session[:deploy_datum_id]
    @deploy_datum = DeployDatum.find(deploy_datum_id)
    @deploy_datum.update_attributes(:status=>Setting.deploy_datum_status.finish)
    session[:deploy_datum_id] = nil
  end

  private

  def necessary_conditions
    if !session[:deploy_datum_id]
      redirect_to deploy_data_url, notice: '还没有创建上线单'
    end

    #TODO: 同一时间只允许一个用户操作上线
  end

  def parse_response(response)
    dom_tree = XmlSimple.xml_in(response)
    status = dom_tree["machine"][0]["status"][0]
    detail = dom_tree["machine"][0]["detail"][0]
    return status, detail
  end
end
