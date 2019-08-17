ActiveRecord::Schema.define(version: 2019_08_17_132105) do

  create_table "cuisines", force: :cascade do |t|
    t.string "name"
  end

  create_table "recipe_types", force: :cascade do |t|
    t.string "name"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "title"
    t.string "difficulty"
    t.integer "cook_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "ingredients"
    t.text "cook_method"
    t.integer "recipe_type_id"
    t.integer "cuisine_id"
    t.index ["cuisine_id"], name: "index_recipes_on_cuisine_id"
    t.index ["recipe_type_id"], name: "index_recipes_on_recipe_type_id"
  end

end
