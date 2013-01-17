class TableSchemasController < ApplicationController
  def index
    if params[:owner] == nil
      @table_schemas = TableSchema.all
      @tag_table_schemas = TagTableSchema.all
    else
      @table_schemas = TableSchema.where(:owner=>params[:owner])
      @tag_table_schemas = TagTableSchema.where(:owner=>params[:owner])
    end
  end

  def show
    @table_schema = TableSchema.find(params[:id])
  end

  def new
    @table_schema = TableSchema.new
  end

  def edit
    @table_schema = TableSchema.find(params[:id])
  end

  def create
    @table_schema = TableSchema.new(params[:table_schema])

    if @table_schema.save
      redirect_to @table_schema, notice: 'Table schema was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @table_schema = TableSchema.find(params[:id])

    if @table_schema.update_attributes(params[:table_schema])
      redirect_to @table_schema, notice: 'Table schema was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @table_schema = TableSchema.find(params[:id])
    @table_schema.destroy

    redirect_to table_schemas_url
  end

  def create_tag
    @table_schema = TableSchema.find(params[:table_schema][:id])
    @tag_table_schema = TagTableSchema.new
    @tag_table_schema.clone_with_table_schema(@table_schema, params[:table_schema][:tag_version])

    #TODO: 如果save失败, 需要用notice通知
    @tag_table_schema.save
    redirect_to table_schemas_url
  end
end
