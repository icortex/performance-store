# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110926211405) do

  create_table "brands", :force => true do |t|
    t.string   "brand"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carriers", :force => true do |t|
    t.string   "company"
    t.string   "city"
    t.string   "contact"
    t.string   "email"
    t.string   "phone"
    t.string   "address"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cloth_types", :force => true do |t|
    t.string   "cloth_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "colors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rgb"
  end

  create_table "contacts", :force => true do |t|
    t.string   "key"
    t.string   "value"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expense_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expenses", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "cost"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "expense_type_id"
    t.integer  "headquarter_id"
  end

  create_table "headquarters", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lot_products", :force => true do |t|
    t.integer  "lot_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.decimal  "cost",                :precision => 10, :scale => 0
    t.integer  "cost_cop"
    t.integer  "sales_cost"
    t.integer  "utility"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "unassigned_quantity"
  end

  create_table "lots", :force => true do |t|
    t.date     "arrival_date"
    t.integer  "freight"
    t.string   "carrier"
    t.string   "origin"
    t.integer  "weight"
    t.integer  "total_cost"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.date     "birthday"
    t.string   "document_id"
    t.string   "gender"
    t.string   "phone"
    t.string   "mobile"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "pin"
    t.string   "city"
  end

  create_table "products", :force => true do |t|
    t.integer  "brand_id"
    t.integer  "cloth_type_id"
    t.string   "reference"
    t.string   "model"
    t.string   "barcode"
    t.string   "gender"
    t.integer  "size_id"
    t.integer  "color_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "sale_products", :force => true do |t|
    t.integer  "sale_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sales", :force => true do |t|
    t.integer  "person_id"
    t.integer  "discount"
    t.string   "discount_reason"
    t.integer  "iva"
    t.integer  "total"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "headquarter_id"
    t.integer  "total_cost"
    t.boolean  "separated",       :default => false
    t.integer  "seller_id"
    t.boolean  "voided",          :default => false
  end

  create_table "separates", :force => true do |t|
    t.integer  "sale_id"
    t.integer  "payment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "payment_cost"
  end

  create_table "sizes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stocks", :force => true do |t|
    t.integer  "product_id"
    t.integer  "quantity"
    t.integer  "price"
    t.integer  "headquarter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cost"
    t.integer  "lot_product_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",       :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",       :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.integer  "person_id"
    t.boolean  "validated",                             :default => false
    t.string   "type",                                  :default => "Seller"
    t.integer  "headquarter_id",                        :default => 1
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "variables", :force => true do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
