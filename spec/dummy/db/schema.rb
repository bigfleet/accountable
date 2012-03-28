# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20120328194712) do

  create_table "account_joins", :force => true do |t|
    t.integer "detail_account_id"
    t.integer "summary_account_id"
  end

  add_index "account_joins", ["detail_account_id"], :name => "index_account_joins_on_detail_account_id"
  add_index "account_joins", ["summary_account_id"], :name => "index_account_joins_on_summary_account_id"

  create_table "accounts", :force => true do |t|
    t.string  "type"
    t.string  "name"
    t.integer "owner_id"
    t.string  "owner_type"
  end

  add_index "accounts", ["owner_id", "owner_type"], :name => "index_accounts_on_owner_id_and_owner_type"

  create_table "balances", :force => true do |t|
    t.integer  "account_id"
    t.datetime "evaluated_at"
    t.decimal  "balance",      :precision => 14, :scale => 2
  end

  add_index "balances", ["account_id"], :name => "index_balances_on_account_id"

  create_table "entries", :force => true do |t|
    t.string  "type"
    t.integer "detail_account_id"
    t.integer "transaction_id"
    t.decimal "amount",            :precision => 14, :scale => 2
  end

  add_index "entries", ["detail_account_id"], :name => "index_entries_on_detail_account_id"
  add_index "entries", ["transaction_id"], :name => "index_entries_on_transaction_id"

  create_table "invoice_lines", :force => true do |t|
    t.integer "invoice_id"
    t.integer "line_item_id"
  end

  add_index "invoice_lines", ["invoice_id"], :name => "index_invoice_lines_on_invoice_id"
  add_index "invoice_lines", ["line_item_id"], :name => "index_invoice_lines_on_line_item_id"

  create_table "invoices", :force => true do |t|
    t.integer "buyer_account_id"
    t.integer "seller_account_id"
    t.boolean "closed",            :default => false
  end

  add_index "invoices", ["buyer_account_id"], :name => "index_invoices_on_buyer_account_id"
  add_index "invoices", ["seller_account_id"], :name => "index_invoices_on_seller_account_id"

  create_table "transactions", :force => true do |t|
    t.string   "type"
    t.string   "description"
    t.datetime "transaction_date"
    t.integer  "auxilliary_model_id"
    t.string   "auxilliary_model_type"
    t.boolean  "require_funds"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "transactions", ["auxilliary_model_id", "auxilliary_model_type"], :name => "index_transactions_on_auxilliary_model"
  add_index "transactions", ["transaction_date"], :name => "index_transactions_on_transaction_date"

end
