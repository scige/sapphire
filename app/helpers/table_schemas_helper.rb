module TableSchemasHelper
  def divide_group_fields
      group_fields_hash = {}
      @table_schema.table_fields.each do |field|
          if group_fields_hash.has_key?(field.group)
              group_fields_hash[field.group] << field
          else
              group_fields_hash[field.group] = [field]
          end
      end

      return group_fields_hash
  end
end
