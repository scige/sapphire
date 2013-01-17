class TagTableSchemasController < ApplicationController
  def show
    @tag_table_schema = TagTableSchema.find(params[:id])
  end

  def destroy
    @tag_table_schema = TagTableSchema.find(params[:id])
    @tag_table_schema.destroy

    redirect_to table_schemas_url
  end
end
