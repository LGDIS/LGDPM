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

ActiveRecord::Schema.define(:version => 20130201102920) do



  create_table "constants", :force => true do |t|
    t.string   "kind1"
    t.string   "kind2"
    t.string   "kind3"
    t.string   "text"
    t.string   "value"
    t.integer  "_order"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "evacuees", :force => true do |t|
    t.integer  "local_person_id"
    t.integer  "lgdpf_person_id"
    t.string   "person_record_id",                :limit => 500
    t.string   "family_name",                     :limit => 500
    t.string   "given_name",                      :limit => 500
    t.string   "alternate_family_name",           :limit => 500
    t.string   "alternate_given_name",            :limit => 500
    t.date     "date_of_birth"
    t.string   "sex",                             :limit => 1
    t.string   "age",                             :limit => 500
    t.string   "home_postal_code",                :limit => 500
    t.string   "in_city_flag",                    :limit => 1
    t.string   "home_state",                      :limit => 500
    t.string   "home_city",                       :limit => 500
    t.string   "home_street",                     :limit => 500
    t.string   "house_number",                    :limit => 500
    t.string   "shelter_name",                    :limit => 20
    t.string   "refuge_status",                   :limit => 1
    t.text     "refuge_reason"
    t.date     "shelter_entry_date"
    t.date     "shelter_leave_date"
    t.string   "next_place",                      :limit => 100
    t.string   "next_place_phone",                :limit => 20
    t.string   "injury_flag",                     :limit => 1
    t.text     "injury_condition"
    t.string   "allergy_flag",                    :limit => 1
    t.text     "allergy_cause"
    t.string   "pregnancy",                       :limit => 1
    t.string   "baby",                            :limit => 1
    t.string   "upper_care_level_three",          :limit => 2
    t.string   "elderly_alone",                   :limit => 1
    t.string   "elderly_couple",                  :limit => 1
    t.string   "bedridden_elderly",               :limit => 1
    t.string   "elderly_dementia",                :limit => 1
    t.string   "rehabilitation_certificate",      :limit => 2
    t.string   "physical_disability_certificate", :limit => 1
    t.integer  "juki_status"
    t.text     "note"
    t.string   "family_well",                     :limit => 1
    t.string   "juki_number",                     :limit => 500
    t.string   "linked_by",                       :limit => 100
    t.datetime "linked_at"
    t.string   "created_by",                      :limit => 100
    t.string   "updated_by",                      :limit => 100
    t.datetime "deleted_at"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  create_table "juki_histories", :force => true do |t|
    t.integer  "number"
    t.integer  "status"
    t.string   "created_by", :limit => 100
    t.string   "updated_by", :limit => 100
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "jukis", :force => true do |t|
    t.string   "id_number",                       :limit => 15
    t.string   "household_number",                :limit => 15
    t.string   "residents_type",                  :limit => 1
    t.string   "residents_state",                 :limit => 1
    t.string   "residents_code",                  :limit => 11
    t.string   "family_name",                     :limit => 100
    t.string   "given_name",                      :limit => 100
    t.string   "alternate_family_name",           :limit => 100
    t.string   "alternate_given_name",            :limit => 100
    t.string   "sex",                             :limit => 1
    t.string   "year_number",                     :limit => 2
    t.date     "date_of_birth"
    t.string   "relation1",                       :limit => 2
    t.string   "relation2",                       :limit => 2
    t.string   "relation3",                       :limit => 2
    t.string   "relation4",                       :limit => 2
    t.string   "household_family_name",           :limit => 100
    t.string   "household_given_name",            :limit => 100
    t.string   "household_alternate_family_name", :limit => 100
    t.string   "household_alternate_given_name",  :limit => 100
    t.string   "address_code",                    :limit => 30
    t.string   "address",                         :limit => 100
    t.string   "building_name",                   :limit => 150
    t.string   "postal_code",                     :limit => 10
    t.string   "former_address_code",             :limit => 30
    t.string   "former_address",                  :limit => 100
    t.string   "former_building_name",            :limit => 150
    t.string   "former_postal_code",              :limit => 10
    t.string   "new_address_code",                :limit => 30
    t.string   "new_address",                     :limit => 100
    t.string   "new_building_name",               :limit => 150
    t.string   "new_postal_code",                 :limit => 10
    t.string   "new_address_division",            :limit => 1
    t.string   "domicile",                        :limit => 100
    t.string   "domicile_code",                   :limit => 30
    t.string   "family_head",                     :limit => 100
    t.date     "became_change_date"
    t.date     "became_report_date"
    t.string   "became_change_reason",            :limit => 2
    t.date     "decided_change_date"
    t.date     "decided_report_date"
    t.string   "decided_change_reason",           :limit => 2
    t.date     "lost_change_date"
    t.date     "lost_report_date"
    t.string   "lost_change_reason",              :limit => 2
    t.datetime "change_date"
    t.string   "original_area",                   :limit => 50
    t.string   "change_division",                 :limit => 1
    t.string   "change_reason",                   :limit => 2
    t.string   "created_by",                      :limit => 100
    t.string   "updated_by",                      :limit => 100
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  create_table "local_people", :force => true do |t|
    t.integer  "lgdpf_person_id"
    t.string   "person_record_id",                :limit => 500
    t.datetime "entry_date"
    t.datetime "expiry_date"
    t.string   "author_name",                     :limit => 500
    t.string   "author_email",                    :limit => 500
    t.string   "author_phone",                    :limit => 500
    t.string   "source_name",                     :limit => 500
    t.datetime "source_date"
    t.string   "source_url",                      :limit => 500
    t.string   "full_name",                       :limit => 500
    t.string   "given_name",                      :limit => 500
    t.string   "family_name",                     :limit => 500
    t.string   "alternate_names",                 :limit => 500
    t.text     "description"
    t.string   "sex",                             :limit => 1
    t.date     "date_of_birth"
    t.string   "age",                             :limit => 500
    t.string   "home_street",                     :limit => 500
    t.string   "home_neighborhood",               :limit => 500
    t.string   "home_city",                       :limit => 500
    t.string   "home_state",                      :limit => 500
    t.string   "home_postal_code",                :limit => 500
    t.string   "home_country",                    :limit => 500
    t.string   "photo_url",                       :limit => 500
    t.string   "profile_urls",                    :limit => 500
    t.integer  "public_flag"
    t.string   "in_city_flag",                    :limit => 1
    t.string   "shelter_name",                    :limit => 20
    t.string   "refuge_status",                   :limit => 1
    t.text     "refuge_reason"
    t.date     "shelter_entry_date"
    t.date     "shelter_leave_date"
    t.string   "next_place",                      :limit => 100
    t.string   "next_place_phone",                :limit => 20
    t.string   "injury_flag",                     :limit => 1
    t.text     "injury_condition"
    t.string   "allergy_flag",                    :limit => 1
    t.text     "allergy_cause"
    t.string   "pregnancy",                       :limit => 1
    t.string   "baby",                            :limit => 1
    t.string   "upper_care_level_three",          :limit => 2
    t.string   "elderly_alone",                   :limit => 1
    t.string   "elderly_couple",                  :limit => 1
    t.string   "bedridden_elderly",               :limit => 1
    t.string   "elderly_dementia",                :limit => 1
    t.string   "rehabilitation_certificate",      :limit => 2
    t.string   "physical_disability_certificate", :limit => 1
    t.boolean  "link_flag",                                      :default => false
    t.boolean  "notes_disabled",                                 :default => false
    t.boolean  "email_flag",                                     :default => false
    t.integer  "status"
    t.string   "last_known_location",             :limit => 500
    t.string   "family_well",                     :limit => 1
    t.string   "approved_by",                     :limit => 100
    t.datetime "approved_at"
    t.string   "created_by",                      :limit => 100
    t.string   "updated_by",                      :limit => 100
    t.datetime "deleted_at"
    t.datetime "created_at",                                                        :null => false
    t.datetime "updated_at",                                                        :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login",              :default => "", :null => false
    t.integer  "sign_in_count",      :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["login", "provider", "uid"], :name => "index_users_on_login_and_provider_and_uid", :unique => true

  set_column_comment 'constants', 'kind1', '種別'
  set_column_comment 'constants', 'kind2', 'テーブル名'
  set_column_comment 'constants', 'kind3', 'カラム名'
  set_column_comment 'constants', 'text', 'テキスト'
  set_column_comment 'constants', 'value', '値'
  set_column_comment 'constants', '_order', '並び順'
  set_column_comment 'constants', 'created_at', '登録日時'
  set_column_comment 'constants', 'updated_at', '更新日時'

  set_column_comment 'evacuees', 'local_person_id', 'LocalPersonのid'
  set_column_comment 'evacuees', 'lgdpf_person_id', 'LGDPFのperson_id'
  set_column_comment 'evacuees', 'person_record_id', 'GooglePersonFinderのperson_id'
  set_column_comment 'evacuees', 'family_name', '氏名（姓）'
  set_column_comment 'evacuees', 'given_name', '氏名（名）'
  set_column_comment 'evacuees', 'alternate_family_name', '氏名カナ（姓）'
  set_column_comment 'evacuees', 'alternate_given_name', '氏名カナ（名）'
  set_column_comment 'evacuees', 'date_of_birth', '生年月日'
  set_column_comment 'evacuees', 'sex', '性別'
  set_column_comment 'evacuees', 'age', '年齢'
  set_column_comment 'evacuees', 'home_postal_code', '郵便番号'
  set_column_comment 'evacuees', 'in_city_flag', '市内・市外区分'
  set_column_comment 'evacuees', 'home_state', '都道府県'
  set_column_comment 'evacuees', 'home_city', '市区町村'
  set_column_comment 'evacuees', 'home_street', '町名'
  set_column_comment 'evacuees', 'house_number', '番地'
  set_column_comment 'evacuees', 'shelter_name', '避難所'
  set_column_comment 'evacuees', 'refuge_status', '避難状況'
  set_column_comment 'evacuees', 'refuge_reason', '避難理由'
  set_column_comment 'evacuees', 'shelter_entry_date', '入所年月日'
  set_column_comment 'evacuees', 'shelter_leave_date', '退所年月日'
  set_column_comment 'evacuees', 'next_place', '退所先'
  set_column_comment 'evacuees', 'next_place_phone', '退所先電話番号'
  set_column_comment 'evacuees', 'injury_flag', '負傷'
  set_column_comment 'evacuees', 'injury_condition', '負傷内容'
  set_column_comment 'evacuees', 'allergy_flag', 'アレルギー'
  set_column_comment 'evacuees', 'allergy_cause', 'アレルギー物質'
  set_column_comment 'evacuees', 'pregnancy', '妊婦'
  set_column_comment 'evacuees', 'baby', '乳幼児'
  set_column_comment 'evacuees', 'upper_care_level_three', '要介護度3以上'
  set_column_comment 'evacuees', 'elderly_alone', '一人暮らし高齢者（65歳以上）'
  set_column_comment 'evacuees', 'elderly_couple', '高齢者世帯（夫婦共に65歳以上）'
  set_column_comment 'evacuees', 'bedridden_elderly', '寝たきり高齢者'
  set_column_comment 'evacuees', 'elderly_dementia', '認知症高齢者'
  set_column_comment 'evacuees', 'rehabilitation_certificate', '療育手帳所持者'
  set_column_comment 'evacuees', 'physical_disability_certificate', '身体障害者手帳所持者'
  set_column_comment 'evacuees', 'juki_status', '住基ステータス'
  set_column_comment 'evacuees', 'note', '備考'
  set_column_comment 'evacuees', 'family_well', '家族も無事'
  set_column_comment 'evacuees', 'juki_number', '住基番号'
  set_column_comment 'evacuees', 'linked_by', '連携者'
  set_column_comment 'evacuees', 'linked_at', '連携日時'
  set_column_comment 'evacuees', 'created_by', '登録者'
  set_column_comment 'evacuees', 'updated_by', '更新者'
  set_column_comment 'evacuees', 'deleted_at', '削除日時'
  set_column_comment 'evacuees', 'created_at', '登録日時'
  set_column_comment 'evacuees', 'updated_at', '更新日時'

  set_column_comment 'juki_histories', 'number', '件数'
  set_column_comment 'juki_histories', 'status', 'ステータス'
  set_column_comment 'juki_histories', 'created_by', '登録者'
  set_column_comment 'juki_histories', 'updated_by', '更新者'
  set_column_comment 'juki_histories', 'created_at', '登録日時'
  set_column_comment 'juki_histories', 'updated_at', '更新日時'

  set_column_comment 'jukis', 'id_number', '識別番号'
  set_column_comment 'jukis', 'household_number', '世帯番号'
  set_column_comment 'jukis', 'residents_type', '住民種別'
  set_column_comment 'jukis', 'residents_state', '住民状態'
  set_column_comment 'jukis', 'residents_code', '住民票コード'
  set_column_comment 'jukis', 'family_name', '氏名（姓）'
  set_column_comment 'jukis', 'given_name', '氏名（名）'
  set_column_comment 'jukis', 'alternate_family_name', '氏名カナ（姓）'
  set_column_comment 'jukis', 'alternate_given_name', '氏名カナ（名）'
  set_column_comment 'jukis', 'sex', '性別'
  set_column_comment 'jukis', 'year_number', '生年月日：年号'
  set_column_comment 'jukis', 'date_of_birth', '生年月日'
  set_column_comment 'jukis', 'relation1', '続柄1'
  set_column_comment 'jukis', 'relation2', '続柄2'
  set_column_comment 'jukis', 'relation3', '続柄3'
  set_column_comment 'jukis', 'relation4', '続柄4'
  set_column_comment 'jukis', 'household_family_name', '世帯主氏名（姓）'
  set_column_comment 'jukis', 'household_given_name', '世帯主氏名（名）'
  set_column_comment 'jukis', 'household_alternate_family_name', '世帯主氏名カナ（姓）'
  set_column_comment 'jukis', 'household_alternate_given_name', '世帯主氏名カナ（名）'
  set_column_comment 'jukis', 'address_code', '現住所：住所コード'
  set_column_comment 'jukis', 'address', '現住所：住所'
  set_column_comment 'jukis', 'building_name', '現住所：方書'
  set_column_comment 'jukis', 'postal_code', '現住所：郵便番号'
  set_column_comment 'jukis', 'former_address_code', '前住所：住所コード'
  set_column_comment 'jukis', 'former_address', '前住所：住所'
  set_column_comment 'jukis', 'former_building_name', '前住所：方書'
  set_column_comment 'jukis', 'former_postal_code', '前住所：郵便番号'
  set_column_comment 'jukis', 'new_address_code', '転出先：住所コード'
  set_column_comment 'jukis', 'new_address', '転出先：住所'
  set_column_comment 'jukis', 'new_building_name', '転出先：方書'
  set_column_comment 'jukis', 'new_postal_code', '転出先：郵便番号'
  set_column_comment 'jukis', 'new_address_division', '転出先区分'
  set_column_comment 'jukis', 'domicile', '本籍'
  set_column_comment 'jukis', 'domicile_code', '本籍住所コード'
  set_column_comment 'jukis', 'family_head', '筆頭者'
  set_column_comment 'jukis', 'became_change_date', '住民となった情報：異動年月日'
  set_column_comment 'jukis', 'became_report_date', '住民となった情報：届出年月日'
  set_column_comment 'jukis', 'became_change_reason', '住民となった情報：増異動事由'
  set_column_comment 'jukis', 'decided_change_date', '住民を定めた情報：異動年月日'
  set_column_comment 'jukis', 'decided_report_date', '住民を定めた情報：届出年月日'
  set_column_comment 'jukis', 'decided_change_reason', '住民を定めた情報：異動事由'
  set_column_comment 'jukis', 'lost_change_date', '住民でなくなった情報：異動年月日'
  set_column_comment 'jukis', 'lost_report_date', '住民でなくなった情報：届出年月日'
  set_column_comment 'jukis', 'lost_change_reason', '住民でなくなった情報：減異動事由'
  set_column_comment 'jukis', 'change_date', '異動年月日'
  set_column_comment 'jukis', 'original_area', '独自領域'
  set_column_comment 'jukis', 'change_division', '異動中区分'
  set_column_comment 'jukis', 'change_reason', '異動事由'
  set_column_comment 'jukis', 'created_by', '登録者'
  set_column_comment 'jukis', 'updated_by', '更新者'
  set_column_comment 'jukis', 'created_at', '登録日時'
  set_column_comment 'jukis', 'updated_at', '更新日時'

  set_column_comment 'local_people', 'lgdpf_person_id', 'LGDPFのperson_id'
  set_column_comment 'local_people', 'person_record_id', 'GooglePersonFinderのperson_id'
  set_column_comment 'local_people', 'entry_date', 'レコード作成日時'
  set_column_comment 'local_people', 'expiry_date', 'レコード削除予定日時'
  set_column_comment 'local_people', 'author_name', 'レコード作成者名'
  set_column_comment 'local_people', 'author_email', 'レコード作成者のメールアドレス'
  set_column_comment 'local_people', 'author_phone', 'レコード作成者の電話番号'
  set_column_comment 'local_people', 'source_name', '情報元のサイト名'
  set_column_comment 'local_people', 'source_date', '情報元の投稿日'
  set_column_comment 'local_people', 'source_url', '情報元のサイトURL'
  set_column_comment 'local_people', 'full_name', '避難者名前'
  set_column_comment 'local_people', 'given_name', '避難者_名'
  set_column_comment 'local_people', 'family_name', '避難者_姓'
  set_column_comment 'local_people', 'alternate_names', '避難者_よみがな'
  set_column_comment 'local_people', 'description', '説明'
  set_column_comment 'local_people', 'sex', '性別'
  set_column_comment 'local_people', 'date_of_birth', '生年月日'
  set_column_comment 'local_people', 'age', '年齢'
  set_column_comment 'local_people', 'home_street', '町名'
  set_column_comment 'local_people', 'home_neighborhood', '近隣'
  set_column_comment 'local_people', 'home_city', '市区町村'
  set_column_comment 'local_people', 'home_state', '都道府県'
  set_column_comment 'local_people', 'home_postal_code', '郵便番号'
  set_column_comment 'local_people', 'home_country', '出身国'
  set_column_comment 'local_people', 'photo_url', '写真のURL'
  set_column_comment 'local_people', 'profile_urls', 'プロフィールURL'
  set_column_comment 'local_people', 'public_flag', '公開フラグ'
  set_column_comment 'local_people', 'in_city_flag', '市内・市外区分'
  set_column_comment 'local_people', 'shelter_name', '避難所'
  set_column_comment 'local_people', 'refuge_status', '避難状況'
  set_column_comment 'local_people', 'refuge_reason', '避難理由'
  set_column_comment 'local_people', 'shelter_entry_date', '入所年月日'
  set_column_comment 'local_people', 'shelter_leave_date', '退所年月日'
  set_column_comment 'local_people', 'next_place', '退所先'
  set_column_comment 'local_people', 'next_place_phone', '退所先電話番号'
  set_column_comment 'local_people', 'injury_flag', '負傷'
  set_column_comment 'local_people', 'injury_condition', '負傷内容'
  set_column_comment 'local_people', 'allergy_flag', 'アレルギー'
  set_column_comment 'local_people', 'allergy_cause', 'アレルギー物質'
  set_column_comment 'local_people', 'pregnancy', '妊婦'
  set_column_comment 'local_people', 'baby', '乳幼児'
  set_column_comment 'local_people', 'upper_care_level_three', '要介護度3以上'
  set_column_comment 'local_people', 'elderly_alone', '一人暮らし高齢者（65歳以上）'
  set_column_comment 'local_people', 'elderly_couple', '高齢者世帯（夫婦共に65歳以上）'
  set_column_comment 'local_people', 'bedridden_elderly', '寝たきり高齢者'
  set_column_comment 'local_people', 'elderly_dementia', '認知症高齢者'
  set_column_comment 'local_people', 'rehabilitation_certificate', '療育手帳所持者'
  set_column_comment 'local_people', 'physical_disability_certificate', '身体障害者手帳所持者'
  set_column_comment 'local_people', 'link_flag', '連携フラグ'
  set_column_comment 'local_people', 'notes_disabled', 'メモ無効フラグ'
  set_column_comment 'local_people', 'email_flag', '新着メッセージ受取フラグ'
  set_column_comment 'local_people', 'status', '状況'
  set_column_comment 'local_people', 'last_known_location', '最後に見かけた場所'
  set_column_comment 'local_people', 'family_well', '家族も無事'
  set_column_comment 'local_people', 'approved_by', '承認者'
  set_column_comment 'local_people', 'approved_at', '承認日時'
  set_column_comment 'local_people', 'created_by', '登録者'
  set_column_comment 'local_people', 'updated_by', '更新者'
  set_column_comment 'local_people', 'deleted_at', '削除日時'
  set_column_comment 'local_people', 'created_at', '登録日時'
  set_column_comment 'local_people', 'updated_at', '更新日時'

  set_column_comment 'users', 'provider', '認可プロバイダ名'
  set_column_comment 'users', 'uid', '認可プロバイダのユーザ識別子'

end
