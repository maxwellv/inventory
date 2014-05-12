class CreateJewelries < ActiveRecord::Migration
  def change
    create_table :jewelries do |t|
      #t.int :id --automatically generated
      t.integer :jewelry_type
      t.float :materials_cost
      t.float :hours_worked
      t.timestamps
    end
    create_table :jewelries_sold do |t|
      #t.int :id --automatically generated
      t.integer :jewelry_type
      t.float :materials_cost
      t.float :hours_worked
      t.timestamps
    end
  end
end
