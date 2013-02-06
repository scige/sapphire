class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

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
