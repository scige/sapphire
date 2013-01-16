module RecommendConfigsHelper
    def get_first_table(owner)
        table_schemas = TableSchema.where(:owner=>owner)
        table_schemas.length == 0 ? nil : table_schemas[0].table
    end
end
