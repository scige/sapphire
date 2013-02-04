class TableSchemasController < ApplicationController
  def index
    if !params[:owner]
      @table_schemas = TableSchema.order_by([[:owner, :asc], [:id, :asc]])
      @tag_table_schemas = TagTableSchema.order_by([[:table, :asc], [:id, :asc]])
    else
      @table_schemas = TableSchema.where(:owner=>params[:owner]).order_by([[:owner, :asc], [:id, :asc]])
      @tag_table_schemas = TagTableSchema.where(:owner=>params[:owner]).order_by([[:table, :asc], [:id, :asc]])
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
    table_schema_old = @table_schema.dup

    if @table_schema.update_attributes(params[:table_schema])
      table_schema_new = @table_schema.dup
      #获取更新详情：增加，删除，修改的field
      diff_fields = get_diff_fields(table_schema_old.table_fields, table_schema_new.table_fields)
      if !diff_fields
        #TODO: recover to old table_schema, 下面的恢复方式无效
        #@table_schema.update_attributes(table_schema_old.attributes)
        flash[:error] = 'Table schema was updated, but recommend config data updated failed. Reason: diff_field failed!'
        redirect_to @table_schema and return
      end

      #更新已经存在的数据
      update_recommend_configs(diff_fields, table_schema_old, @table_schema)

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

    tag_table_schema_find = TagTableSchema.where(:table=>@tag_table_schema.table,
                                                 :version=>@tag_table_schema.version)
    
    if tag_table_schema_find.count > 0
      flash[:error] = "Create table: [#{@tag_table_schema.table}] tag: [#{@tag_table_schema.version}] failed. Reason: it has exist."
      redirect_to table_schemas_url and return
    end

    #要先save tag_table_schema, 然后再save tag_recommend_config
    #否则tag_recommend_config.tag_table_schema_id为nil
    if !@tag_table_schema.save
      flash[:error] = "Create table: [#{@tag_table_schema.table}] tag: [#{@tag_table_schema.version}] failed. Reason: save table schema failed."
      redirect_to table_schemas_url and return
    end

    @table_schema.recommend_configs.each do |recommend_config|
      recommend_config_dup = recommend_config.dup
      recommend_config_dup.attributes.delete("table_schema_id")
      recommend_config_dup.attributes.delete("created_at")
      recommend_config_dup.attributes.delete("updated_at")
      tag_recommend_config = TagRecommendConfig.new(recommend_config_dup.attributes)
      @tag_table_schema.tag_recommend_configs << tag_recommend_config
      tag_recommend_config.save
    end

    redirect_to table_schemas_url, notice: "Create table: [#{@tag_table_schema.table}] tag: [#{@tag_table_schema.version}] successed."
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
  #    recommend_config_dup = recommend_config.dup
  #    recommend_config_dup.attributes.delete("table_schema_id")
  #    tag_recommend_config = TagRecommendConfig.new(recommend_config_dup.attributes)
  #    @tag_table_schema.tag_recommend_configs << tag_recommend_config
  #    tag_recommend_config.save
  #  end

  #  redirect_to table_schemas_url
  #end

  private

  def update_recommend_configs(diff_fields, table_schema_old, table_schema_new)
    table_schema_new.recommend_configs.each do |recommend_config|
      #只拷贝table_fields对应的属性, 接下来只修改这些属性
      #如果使用recommend_config.attributes, 会拷贝全部属性
      #比如_id, update_at, table_schema_id等，接下来可能会误操作这些属性
      update_attributes = clone_attributes(recommend_config, table_schema_old)
      if !update_attributes
        #TODO: 跳过这条数据继续处理其他数据，但这条数据如何处理？
        #TODO: 在日志中记录这条数据的相关信息
        next
      end
      #更新field的数据, 也可以新增group
      diff_fields[:remove].each do |table_field|
        update_attributes[table_field["group"]].delete(table_field["name"])
      end

      diff_fields[:add].each do |table_field|
        #新增group
        if !update_attributes.has_key?(table_field["group"])
          update_attributes[table_field["group"]] = {}
        end
        update_attributes[table_field["group"]][table_field["name"]] = table_field["default_value"]
      end

      diff_fields[:modify].each do |table_field_pair|
        ts_old = table_field_pair["old"]
        ts_new = table_field_pair["new"]
        #先插入新的字段, 更新默认值, 然后再删除旧的字段
        if !update_attributes[ts_new["group"]].has_key?(ts_old["name"]) 
          update_attributes[ts_new["group"]][ts_new["name"]] = ts_new["default_value"]
        else
          if ts_old["default_value"] == ts_new["default_value"]
            #此时一定是 ts_old["name"] == ts_new["name"]
            update_attributes[ts_new["group"]][ts_new["name"]] = update_attributes[ts_new["group"]][ts_old["name"]]
          else
            if update_attributes[ts_new["group"]][ts_old["name"]] == "" or update_attributes[ts_new["group"]][ts_old["name"]] == ts_old["default_value"]
              update_attributes[ts_new["group"]][ts_new["name"]] = ts_new["default_value"]
            end
          end

          #不管default_value字段是否更新，只要name字段更新了，就要删除旧的 ts_old["name"]
          if ts_old["name"] != ts_new["name"]
            update_attributes[ts_new["group"]].delete(ts_old["name"])
          end
        end
      end

      logger.debug diff_fields
      logger.debug recommend_config.attributes
      logger.debug update_attributes

      recommend_config.update_attributes(update_attributes)

      #删除空的group
      remove_attributes = []
      update_attributes.each do |key, value|
        if value.length == 0
          remove_attributes << key
        end
      end

      remove_attributes.each do |remove_attribute|
        recommend_config.remove_attribute(remove_attribute)
      end

      logger.debug recommend_config.attributes
      logger.debug remove_attributes

      recommend_config.save
    end
  end

  def get_diff_fields(ts_olds, ts_news)
    diff_fields = {:add=>[], :remove=>[], :modify=>[]}

    ts_news.each do |ts_new|
      is_find = false
      ts_olds.each do |ts_old|
        if ts_new["_id"] == ts_old["_id"]
          is_find = true
          #不支持更新group的操作
          if ts_new["group"] != ts_old["group"]
            return nil
          end
          if ts_new["name"] != ts_old["name"] or
             ts_new["default_value"] != ts_old["default_value"]
            diff_fields[:modify] << {"old"=>ts_old, "new"=>ts_new}
          end
          break
        end
      end

      if !is_find
        diff_fields[:add] << ts_new
      end
    end

    ts_olds.each do |ts_old|
      is_find = false
      ts_news.each do |ts_new|
        if ts_new["_id"] == ts_old["_id"]
          is_find = true
          break
        end
      end

      if !is_find
        diff_fields[:remove] << ts_old
      end
    end

    return diff_fields
  end

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
