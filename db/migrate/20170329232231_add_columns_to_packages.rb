class AddColumnsToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :length, :decimal
    add_column :packages, :width, :decimal
    add_column :packages, :height, :decimal
    add_column :packages, :weight, :decimal
  end
end
