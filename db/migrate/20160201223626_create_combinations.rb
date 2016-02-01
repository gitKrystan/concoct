class CreateCombinations < ActiveRecord::Migration
  def change
    create_table :combinations, id: false do |t|
      t.integer :ingredient_id
      t.integer :complement_id
    end

    add_index(:combinations, [:ingredient_id, :complement_id], :unique => true)
    add_index(:combinations, [:complement_id, :ingredient_id], :unique => true)
  end
end
