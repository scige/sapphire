class RecommendConfigsController < ApplicationController
  def index
    @table_schema = TableSchema.find_by(:table=>params[:table])
    @recommend_configs = @table_schema.recommend_configs.page(params[:page])
  end

  def show
    @table_schema = TableSchema.find_by(:table=>params[:table])
    @recommend_config = RecommendConfig.find(params[:id])

    respond_to do |format|
      format.html
      format.js {render :layout => false}
    end
  end

  def new
    @table_schema = TableSchema.find_by(:table=>params[:table])
    @recommend_config = RecommendConfig.new    #just for test use
  end

  def edit
    @table_schema = TableSchema.find_by(:table=>params[:table])
    @recommend_config = RecommendConfig.find(params[:id])
  end

  def create
    @recommend_config = RecommendConfig.new(params[params[:table]])

    if validate_present?(@recommend_config, params[:table])
      flash[:error] = 'Created recommend config failed. Reason: recommend config has existed.'
      redirect_to recommend_configs_url(:owner=>params[:owner], :table=>params[:table]) and return
    end

    if @recommend_config.save
      redirect_to recommend_config_url(@recommend_config, :owner=>params[:owner], :table=>params[:table]), notice: 'Recommend config was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @recommend_config = RecommendConfig.find(params[:id])

    if @recommend_config.update_attributes(params[:recommend_config])
      redirect_to recommend_config_url(@recommend_config, :owner=>params[:owner], :table=>params[:table]), notice: 'Recommend config was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @recommend_config = RecommendConfig.find(params[:id])
    @recommend_config.destroy

    redirect_to recommend_configs_url(:owner=>params[:owner], :table=>params[:table])
  end

  def batch_edit
    @table_schema = TableSchema.find_by(:table=>params[:table])
  end

  def batch_update
    @table_schema = TableSchema.find(params[:table_schema][:id])
    group = params[:table_field][:group]
    name = params[:table_field][:name]
    value = params[:table_field][:value]
    @table_schema.recommend_configs.each do |recommend_config|
      update_attributes = clone_attributes(recommend_config, @table_schema)
      if !update_attributes
        #TODO: 跳过这条数据继续处理其他数据，但这条数据如何处理？
        #TODO: 在日志中记录这条数据的相关信息
        next
      end
      update_attributes[group][name] = value
      recommend_config.update_attributes(update_attributes)

      #必须在完整attributes的基础上做修改，下面的方式是不行的
      #recommend_config.update_attributes(group=>{name=>value})
    end

    redirect_to recommend_configs_url(:owner=>@table_schema.owner,
                                      :table=>@table_schema.table)
  end

  def copy_new
    @table_schema = TableSchema.find_by(:table=>params[:table])
    @recommend_config = RecommendConfig.find(params[:id])
  end

  def copy_create
    @recommend_config = RecommendConfig.new(params[params[:table]])

    if validate_present?(@recommend_config, params[:table])
      flash[:error] = 'Created recommend config failed. Reason: recommend config has existed.'
      redirect_to recommend_configs_url(:owner=>params[:owner], :table=>params[:table]) and return
    end

    if @recommend_config.save
      redirect_to recommend_config_url(@recommend_config, :owner=>params[:owner], :table=>params[:table]), notice: 'Recommend config was successfully created.'
    else
      render action: "new"
    end
  end

  private

  def validate_present?(recommend_config, table)
    key_group_hash = {}
    @table_schema = TableSchema.find_by(:table=>table)
    @table_schema.group_fields["key"].each do |table_field|
      key_group_hash[table_field.name] = recommend_config["key"][table_field.name]
    end
    rc_find = RecommendConfig.where(:key=>key_group_hash)
    !rc_find.empty?
  end
end
