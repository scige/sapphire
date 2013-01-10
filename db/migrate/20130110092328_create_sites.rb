class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :scope
      t.string :scope_type
      t.string :domain

      t.timestamps
    end
  end
end
