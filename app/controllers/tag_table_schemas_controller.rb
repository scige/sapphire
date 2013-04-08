# coding: utf-8
require "builder"

class TagTableSchemasController < ApplicationController
  before_filter :authenticate_user!

  def show
    @tag_table_schema = TagTableSchema.find(params[:id])
  end

  def destroy
    @tag_table_schema = TagTableSchema.find(params[:id])
    @tag_table_schema.destroy

    redirect_to table_schemas_url
  end

  def dump_xml
    @tag_table_schema = TagTableSchema.find(params[:tag_table_schema][:id])

    @xml_string = ""
    xml = Builder::XmlMarkup.new(:target => @xml_string, :indent => 2)
    xml.instruct!
    xml.recommend {
      xml.owner(@tag_table_schema.owner)
      xml.version(@tag_table_schema.version)
      xml.tag!(@tag_table_schema.table) {
        @tag_table_schema.tag_recommend_configs.each do |tag_rc|
          xml.key(tag_rc["key"]) {
          @tag_table_schema.groups.each do |group_name|
            if group_name == "key"
              next
            end

            xml.tag!(group_name) {
              tag_rc[group_name].each do |key, value|
                #if !value or value == ""
                #  value = "default"
                #end
                xml.tag!(key, value)
              end
            }
          end
          }
        end
      }
    }

    logger.debug @xml_string

    file_path = Rails.public_path + "/recommend_configs/"
    if !Dir.exist?(file_path)
      Dir.mkdir(file_path)
    end
    file_path += @tag_table_schema.owner + "/"
    if !Dir.exist?(file_path)
      Dir.mkdir(file_path)
    end
    file_name = file_path + params[:tag_table_schema][:file_name]
    file = File.new(file_name, 'w')
    file.puts(@xml_string)
    file.close

    release_site_config(file_name)

    flash[:info] = "XML File Address: http://#{request.env["HTTP_HOST"]}/#{file_name[Rails.public_path.length+1..-1]}"

    redirect_to table_schemas_url
  end

  def dump_nsf
    @tag_table_schema = TagTableSchema.find(params[:tag_table_schema][:id])

    @nsf_string = ""
    group_name = "key"
    @tag_table_schema.tag_recommend_configs.each do |tag_rc|
      line_string = ""
      tag_rc[group_name].each do |key, value|
        line_string += value + "\t"
      end
      line_string = line_string[0...-1]
      @nsf_string += line_string + "\n"
    end

    logger.debug @nsf_string

    file_path = Rails.public_path + "/recommend_configs/"
    if !Dir.exist?(file_path)
      Dir.mkdir(file_path)
    end
    file_path += @tag_table_schema.owner + "/"
    if !Dir.exist?(file_path)
      Dir.mkdir(file_path)
    end
    file_name = file_path + params[:tag_table_schema][:file_name]
    file = File.new(file_name, 'w')
    file.puts(@nsf_string)
    file.close

    flash[:info] = "XML File Address: http://#{request.env["HTTP_HOST"]}/#{file_name[Rails.public_path.length+1..-1]}"

    redirect_to table_schemas_url
  end

  private

  def release_site_config(file_name)
    package_path = Rails.public_path + "/recommend_configs/package/"
    conf_path = package_path + "conf/"
    file_name =~ /\d+\.\d+\.\d+\.\d+/
    version = $&
    # 这里默认都是发的site_config package
    package_name = "resys_site_config-#{version}.tar.gz"
    `rm -rf #{package_path}`
    `mkdir -p #{conf_path}`
    `cp #{file_name} #{conf_path}rec_sites.xml`
    `cd #{package_path} ; tar -zcvf #{package_name} conf/`
    `cd #{package_path} ; yes | /home/admin/bin/release.pl panfeng.pan@alibaba-inc.com #{package_name}`
  end
end
