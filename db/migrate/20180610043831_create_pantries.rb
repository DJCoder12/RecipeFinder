class CreatePantries < ActiveRecord::Migration
  def change
    create_table "pantries", force: :cascade do |t|
      t.string "name"
      t.integer "amount"
      t.integer "expDate"
    end
  end
end
  