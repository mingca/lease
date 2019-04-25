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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_04_24_102831) do

  create_table "lease_envelopes", force: :cascade do |t|
    t.integer "template_id"
    t.string "lessee_name"
    t.integer "status", default: 0
    t.string "signed_pdf"
    t.string "envelopable_type"
    t.integer "envelopable_id"
    t.string "signable_type"
    t.integer "signable_id"
    t.index ["envelopable_type", "envelopable_id"], name: "index_lease_envelopes_on_envelopable_type_and_id"
    t.index ["signable_type", "signable_id"], name: "index_lease_envelopes_on_signable_type_and_id"
  end

  create_table "lease_templates", force: :cascade do |t|
    t.string "state"
    t.string "html_file"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
