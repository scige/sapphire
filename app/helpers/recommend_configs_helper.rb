module RecommendConfigsHelper
    def get_owner_first_table(owner)
        table_schemas = TableSchema.where(:owner=>owner)
        table_schemas.length == 0 ? nil : table_schemas[0].table
    end

    def get_owner_all_tables(owner)
        table_schemas = TableSchema.where(:owner=>owner)
    end
end
