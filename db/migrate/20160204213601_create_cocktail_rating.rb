class CreateCocktailRating < ActiveRecord::Migration
  def change
    create_table(:cocktail_ratings) do |t|
      t.column(:cocktail_id, :integer)
      t.column(:score, :integer)

      t.timestamps()
    end
  end
end
