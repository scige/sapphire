# coding: utf-8

class DeployDataController < ApplicationController
  def index
    @deploy_data = DeployDatum.all
  end

  def show
    @deploy_datum = DeployDatum.find(params[:id])
  end

  def new
    @deploy_datum = DeployDatum.new
  end

  def edit
    @deploy_datum = DeployDatum.find(params[:id])
  end

  def create
    @deploy_datum = DeployDatum.new(params[:deploy_datum])

    if @deploy_datum.save
      redirect_to @deploy_datum, notice: '创建上线数据成功'
    else
      render action: "new"
    end
  end

  def update
    @deploy_datum = DeployDatum.find(params[:id])

    if @deploy_datum.update_attributes(params[:deploy_datum])
      redirect_to @deploy_datum, notice: '修改上线数据成功'
    else
      render action: "edit"
    end
  end

  def destroy
    @deploy_datum = DeployDatum.find(params[:id])
    @deploy_datum.destroy

    redirect_to deploy_data_url
  end
end
