class AddAreaToService < ActiveRecord::Migration[5.2]
  def change
    add_column :services, :areas, :string, array: true, default: []
  end
end
