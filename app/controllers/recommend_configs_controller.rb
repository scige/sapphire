class RecommendConfigsController < ApplicationController
  def index
    @table_schema = TableSchema.find_by(:table=>params[:table])
    @recommend_configs = @table_schema.recommend_configs.page(params[:page])
  end

  def show
    @table_schema = TableSchema.find_by(:table=>params[:table])
    @recommend_config = RecommendConfig.find(params[:id])
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

  #完全重复的代码
  def clone_attributes(recommend_config, table_schema)
    #recommend_config是由table_schema生成的，因此所有field都会存在
    #可能某些field的值是""，但不可能某些field不存在
    #如果不是这样，那就是数据有错误
    rc_clone = {}
    table_schema_groups = table_schema.groups
    table_schema_groups.each do |group|
      if !recommend_config.has_attribute?(group)
        return nil
      end
      rc_clone[group] = recommend_config[group].dup
    end

    #extra fields: table_schema_id, updated_at, created_at, _id
    if table_schema_groups.length+4 != recommend_config.attributes.length
      return nil
    end

    if table_schema_groups.length != rc_clone.length
      return nil
    end

    return rc_clone
  end
end
