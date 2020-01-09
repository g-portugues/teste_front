# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_20_203117) do

  create_table "authors", force: :cascade do |t|
    t.string "name", null: false
    t.string "public_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["public_id"], name: "index_authors_on_public_id", unique: true
  end

  create_table "books", force: :cascade do |t|
    t.string "title", null: false
    t.integer "author_id", null: false
    t.float "price", null: false
    t.string "public_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_id"], name: "index_books_on_author_id"
    t.index ["public_id"], name: "index_books_on_public_id", unique: true
  end

  create_table "books_publishers", id: false, force: :cascade do |t|
    t.integer "book_id", null: false
    t.integer "publisher_id", null: false
    t.index ["book_id"], name: "index_books_publishers_on_book_id"
    t.index ["publisher_id"], name: "index_books_publishers_on_publisher_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "book_id", null: false
    t.integer "amount", null: false
    t.float "price", null: false
    t.float "descount"
    t.float "total", null: false
    t.string "public_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_order_items_on_book_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["public_id"], name: "index_order_items_on_public_id", unique: true
  end

  create_table "orders", force: :cascade do |t|
    t.integer "customer_id"
    t.string "public_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["public_id"], name: "index_orders_on_public_id", unique: true
  end

  create_table "publishers", force: :cascade do |t|
    t.string "name", null: false
    t.string "public_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["public_id"], name: "index_publishers_on_public_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name", null: false
    t.string "password_digest"
    t.string "public_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["public_id"], name: "index_users_on_public_id", unique: true
  end

  add_foreign_key "books", "authors"
  add_foreign_key "order_items", "books"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "users", column: "customer_id"
end
