class CreatePruebas < ActiveRecord::Migration
  def change
    create_table :pruebas do |t|
      t.text :descripcion, :null => false
      t.references :uploader, :null => false
      t.references :promesa, :null => false
      
      t.timestamps
    end
  end
  
  def self.down
    drop_table :pruebas
  end
end
