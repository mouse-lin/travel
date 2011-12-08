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

ActiveRecord::Schema.define(:version => 20111208044331) do

  create_table "chufas", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chujingfatuans", :force => true do |t|
    t.integer  "guonei_id"
    t.string   "fatuanri"
    t.integer  "star_id"
    t.integer  "left"
    t.integer  "total"
    t.integer  "tonghang"
    t.integer  "zhike"
    t.time     "daystart"
    t.time     "dayend"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chujingfatuans", ["guonei_id"], :name => "index_chujingfatuans_on_guonei_id"
  add_index "chujingfatuans", ["star_id"], :name => "index_chujingfatuans_on_star_id"

  create_table "chujings", :force => true do |t|
    t.integer  "pifa_id"
    t.integer  "chufa_id"
    t.integer  "linename_id"
    t.integer  "days"
    t.text     "detail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chujings", ["chufa_id"], :name => "index_chujings_on_chufa_id"
  add_index "chujings", ["linename_id"], :name => "index_chujings_on_linename_id"
  add_index "chujings", ["pifa_id"], :name => "index_chujings_on_pifa_id"

  create_table "chujings_dests", :force => true do |t|
    t.integer  "chujing_id"
    t.integer  "dest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chujings_linetypes", :force => true do |t|
    t.integer  "chujing_id"
    t.integer  "linetype_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies", ["product_id"], :name => "index_companies_on_product_id"

  create_table "destcats", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dests", :force => true do |t|
    t.string   "name"
    t.integer  "destcat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dests", ["destcat_id"], :name => "index_dests_on_destcat_id"

  create_table "dests_guoneis", :force => true do |t|
    t.integer  "guonei_id"
    t.integer  "dest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dests_lines", :force => true do |t|
    t.integer  "dest_id"
    t.integer  "line_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dests_qianzhengs", :force => true do |t|
    t.integer  "qianzheng_id"
    t.integer  "dest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dests_zhiyous", :force => true do |t|
    t.integer  "zhiyou_id"
    t.integer  "dest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guoneifatuans", :force => true do |t|
    t.integer  "guonei_id"
    t.string   "fatuanri"
    t.integer  "star_id"
    t.integer  "left"
    t.integer  "total"
    t.integer  "tonghang"
    t.integer  "zhike"
    t.time     "daystart"
    t.time     "dayend"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "guoneifatuans", ["guonei_id"], :name => "index_guoneifatuans_on_guonei_id"
  add_index "guoneifatuans", ["star_id"], :name => "index_guoneifatuans_on_star_id"

  create_table "guoneis", :force => true do |t|
    t.integer  "pifa_id"
    t.integer  "chufa_id"
    t.integer  "linename_id"
    t.integer  "days"
    t.text     "detail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "guoneis", ["chufa_id"], :name => "index_guoneis_on_chufa_id"
  add_index "guoneis", ["linename_id"], :name => "index_guoneis_on_linename_id"
  add_index "guoneis", ["pifa_id"], :name => "index_guoneis_on_pifa_id"

  create_table "guoneis_linetypes", :force => true do |t|
    t.integer  "guonei_id"
    t.integer  "linetype_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "houses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lianxirens", :force => true do |t|
    t.string   "name"
    t.string   "fax"
    t.string   "phone"
    t.string   "msn"
    t.string   "qq"
    t.string   "address"
    t.string   "post_number"
    t.integer  "pifa_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lianxirens", ["pifa_id"], :name => "index_lianxirens_on_pifa_id"

  create_table "linefatuans", :force => true do |t|
    t.integer  "tonghang"
    t.integer  "line_id"
    t.integer  "zhike"
    t.date     "daystart"
    t.date     "dayend"
    t.string   "type"
    t.integer  "visatype_id"
    t.text     "document"
    t.integer  "star_id"
    t.string   "fatuanri"
    t.integer  "left"
    t.integer  "total"
    t.integer  "house_id"
    t.string   "foods"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "linefatuans", ["house_id"], :name => "index_linefatuans_on_house_id"
  add_index "linefatuans", ["line_id"], :name => "index_linefatuans_on_line_id"
  add_index "linefatuans", ["star_id"], :name => "index_linefatuans_on_star_id"
  add_index "linefatuans", ["visatype_id"], :name => "index_linefatuans_on_visatype_id"

  create_table "linenames", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lines", :force => true do |t|
    t.integer  "pifa_id"
    t.integer  "chufa_id"
    t.integer  "linename_id"
    t.integer  "product_id"
    t.integer  "lianxiren_id"
    t.integer  "company_id"
    t.integer  "days"
    t.text     "detail"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lines", ["chufa_id"], :name => "index_lines_on_chufa_id"
  add_index "lines", ["company_id"], :name => "index_lines_on_company_id"
  add_index "lines", ["lianxiren_id"], :name => "index_lines_on_lianxiren_id"
  add_index "lines", ["linename_id"], :name => "index_lines_on_linename_id"
  add_index "lines", ["pifa_id"], :name => "index_lines_on_pifa_id"

  create_table "lines_linetypes", :force => true do |t|
    t.integer  "line_id"
    t.integer  "linetype_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "linetypes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "linetypes_zhiyous", :force => true do |t|
    t.integer  "zhiyou_id"
    t.integer  "lientype_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pifas", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "qianzhengs", :force => true do |t|
    t.integer  "pifa_id"
    t.string   "songqiandi"
    t.string   "songqianguo"
    t.integer  "visatype_id"
    t.text     "document"
    t.integer  "days"
    t.text     "detail"
    t.integer  "tonghang"
    t.integer  "zhike"
    t.time     "daystart"
    t.time     "dayend"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "qianzhengs", ["pifa_id"], :name => "index_qianzhengs_on_pifa_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "stars", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "visatypes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zhiyoufatuans", :force => true do |t|
    t.integer  "guonei_id"
    t.string   "fatuanri"
    t.integer  "star_id"
    t.integer  "house_id"
    t.string   "foods"
    t.integer  "left"
    t.integer  "total"
    t.integer  "tonghang"
    t.integer  "zhike"
    t.time     "daystart"
    t.time     "dayend"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "zhiyoufatuans", ["guonei_id"], :name => "index_zhiyoufatuans_on_guonei_id"
  add_index "zhiyoufatuans", ["house_id"], :name => "index_zhiyoufatuans_on_house_id"
  add_index "zhiyoufatuans", ["star_id"], :name => "index_zhiyoufatuans_on_star_id"

  create_table "zhiyous", :force => true do |t|
    t.integer  "pifa_id"
    t.integer  "chufa_id"
    t.integer  "linename_id"
    t.integer  "days"
    t.text     "detail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "zhiyous", ["chufa_id"], :name => "index_zhiyous_on_chufa_id"
  add_index "zhiyous", ["linename_id"], :name => "index_zhiyous_on_linename_id"
  add_index "zhiyous", ["pifa_id"], :name => "index_zhiyous_on_pifa_id"

end
