class CreateRecipes < ActiveRecord::Migration
  def change
    create_table "recipes", force: :cascade do |t|
      t.string "name"
      t.string "ingredient"
      t.integer "amount"
    end
  end
end