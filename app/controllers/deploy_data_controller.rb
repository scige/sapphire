# coding: utf-8
require 'xmlsimple'

class DeployDataController < ApplicationController
  def index
    @deploy_data = DeployDatum.order_by([[:id, :asc]])
  end

  def show
    @deploy_datum = DeployDatum.find(params[:id])
    #在哪里清除？
    session[:deploy_datum_id] = @deploy_datum.id
  end

  def new
    @deploy_datum = DeployDatum.new
    @our_package_hash = get_release_package
  end

  def edit
    @deploy_datum = DeployDatum.find(params[:id])
    @our_package_hash = get_release_package
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

  def get_release_package
    doc = RestClient.get(Setting.release_address)
    dom_tree = XmlSimple.xml_in(doc)
    link_tree = dom_tree["body"][0]["ul"][0]["li"]
    package_hash = {}
    link_tree.each do |link|
      package = link["a"][0]["href"]
      pos = (package =~ /-\d+\.\d+\.\d+\.\d+\.tar\.gz/)
      next if !pos
      package_name = package[0...pos]

      if package_hash.has_key?(package_name)
        package_hash[package_name] << package
      else
        package_hash[package_name] = [package]
      end
    end

    package_names = [Setting.package_name.rec_package, Setting.package_name.rerank_package, Setting.package_name.site_package, Setting.package_name.item_package, Setting.package_name.trim_package, Setting.package_name.query_package, Setting.package_name.aliguess_package]

    our_package_hash = {}
    package_names.each do |package_name|
      if package_hash.has_key?(package_name)
        package_list = package_hash[package_name]
        if package_list.size <= 5
          our_package_hash[package_name] = package_list
        else
          our_package_hash[package_name] = package_list[package_list.size-5...package_list.size]
        end
      end
    end

    return our_package_hash
  end
end
