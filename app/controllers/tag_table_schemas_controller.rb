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

    redirect_to table_schemas_url
  end
end
