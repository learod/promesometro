class CreateRegiones < ActiveRecord::Migration
  def change
    create_table :regiones do |t|
      t.string :nombre, :null => false
      t.decimal :long
      t.decimal :lat
      
      t.timestamps
    end
  end
end
