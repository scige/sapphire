require "builder"

class TagTableSchemasController < ApplicationController
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
end
