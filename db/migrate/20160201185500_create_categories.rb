class CreateCategories < ActiveRecord::Migration
  def change
    create_table(:categories) do |t|
      t.column(:name, :string)

      t.timestamps()
    end
  end
end
