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
    @tag_table_schema.clone_with_table_schema(@table_schema)
    @tag_table_schema.version = params[:table_schema][:tag_version]

    #要先save tag_table_schema, 然后再save tag_recommend_config
    #否则tag_recommend_config.tag_table_schema_id为nil
    #TODO: 如果save失败, 需要用notice通知
    @tag_table_schema.save

    @table_schema.recommend_configs.each do |recommend_config|
        recommend_config_dup = recommend_config.dup
        recommend_config_dup.attributes.delete("table_schema_id")
        recommend_config_dup.attributes.delete("created_at")
        recommend_config_dup.attributes.delete("updated_at")
        tag_recommend_config = TagRecommendConfig.new(recommend_config_dup.attributes)
        @tag_table_schema.tag_recommend_configs << tag_recommend_config
        tag_recommend_config.save
    end

    redirect_to table_schemas_url
  end

  #def create_tag
  #  @table_schema = TableSchema.find(params[:table_schema][:id])
  #  table_schema_dup = @table_schema.dup
  #  #这里不会递归拷贝构造子对象, 需要手动拷贝table_fields
  #  @tag_table_schema = TagTableSchema.new(table_schema_dup.attributes)
  #  @tag_table_schema.table_fields = @table_schema.table_fields.dup
  #  @tag_table_schema.version = params[:table_schema][:tag_version]

  #  #要先save tag_table_schema, 然后再save tag_recommend_config
  #  #否则tag_recommend_config.tag_table_schema_id为nil
  #  #TODO: 如果save失败, 需要用notice通知
  #  @tag_table_schema.save

  #  @table_schema.recommend_configs.each do |recommend_config|
  #      recommend_config_dup = recommend_config.dup
  #      recommend_config_dup.attributes.delete("table_schema_id")
  #      tag_recommend_config = TagRecommendConfig.new(recommend_config_dup.attributes)
  #      @tag_table_schema.tag_recommend_configs << tag_recommend_config
  #      tag_recommend_config.save
  #  end

  #  redirect_to table_schemas_url
  #end
end
