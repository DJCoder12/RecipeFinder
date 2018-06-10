class CreatePantries < ActiveRecord::Migration
  def change
    create_table "pantries", force: :cascade do |t|
      t.string "name"
      t.string "expDate"
    end
  end
end
  