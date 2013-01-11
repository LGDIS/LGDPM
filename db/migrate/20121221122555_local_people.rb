# -*- coding:utf-8 -*-
class LocalPeople < ActiveRecord::Migration
  def up
    create_table :local_people, :force => true do |t|
      t.column "person_record_id", :string
      t.column "entry_date", :datetime
      t.column "expiry_date", :datetime
      t.column "author_name", :string
      t.column "author_email", :string
      t.column "author_phone", :string
      t.column "source_name", :string
      t.column "source_date", :datetime
      t.column "source_url", :string
      t.column "full_name", :string
      t.column "given_name", :string
      t.column "family_name", :string
      t.column "alternate_names", :string
      t.column "description", :text
      t.column "sex", :integer
      t.column "date_of_birth", :date
      t.column "age", :string
      t.column "house_number", :string
      t.column "home_street", :string
      t.column "home_neighborhood", :string
      t.column "home_city", :string
      t.column "home_state", :string
      t.column "home_postal_code", :string
      t.column "home_country", :string
      t.column "photo_url", :string
      t.column "public_flag", :integer
      t.column "in_city_flag", :integer
      t.column "shelter_name", :string
      t.column "refuge_status", :integer
      t.column "refuge_reason", :string
      t.column "shelter_entry_date", :date
      t.column "shelter_leave_date", :date
      t.column "next_place", :string
      t.column "next_place_phone", :string
      t.column "injury_flag", :integer
      t.column "injury_condition", :string
      t.column "allergy_flag", :integer
      t.column "allergy_cause", :string
      t.column "pregnancy", :integer
      t.column "baby", :integer
      t.column "upper_care_level_three", :integer
      t.column "elderly_alone", :integer
      t.column "elderly_couple", :integer
      t.column "bedridden_elderly", :integer
      t.column "elderly_dementia", :integer
      t.column "rehabilitation_certificate", :integer
      t.column "physical_disability_certificate", :integer
      t.column "status", :integer
      t.column "last_known_location", :string
      t.column "approved_by", :string
      t.column "approved_at", :datetime
      t.column "created_by", :string
      t.column "updated_by", :string
      t.timestamps
    end
    
    set_column_comment(:local_people, :person_record_id, "id")
    set_column_comment(:local_people, :entry_date, "レコード作成日時")
    set_column_comment(:local_people, :expiry_date, "レコード削除予定日時")
    set_column_comment(:local_people, :author_name, "レコード作成者名")
    set_column_comment(:local_people, :author_email, "レコード作成者のメールアドレス")
    set_column_comment(:local_people, :author_phone, "レコード作成者の電話番号")
    set_column_comment(:local_people, :source_name, "情報元のサイト名")
    set_column_comment(:local_people, :source_date, "情報元の投稿日")
    set_column_comment(:local_people, :source_url, "情報元のサイトURL")
    set_column_comment(:local_people, :full_name, "避難者名前")
    set_column_comment(:local_people, :given_name, "避難者_名")
    set_column_comment(:local_people, :family_name, "避難者_姓")
    set_column_comment(:local_people, :alternate_names, "避難者_よみがな")
    set_column_comment(:local_people, :description, "説明")
    set_column_comment(:local_people, :sex, "性別")
    set_column_comment(:local_people, :date_of_birth, "生年月日")
    set_column_comment(:local_people, :age, "年齢")
    set_column_comment(:local_people, :house_number, "番地")
    set_column_comment(:local_people, :home_street, "町名")
    set_column_comment(:local_people, :home_neighborhood, "近隣")
    set_column_comment(:local_people, :home_city, "市区町村")
    set_column_comment(:local_people, :home_state, "都道府県")
    set_column_comment(:local_people, :home_postal_code, "郵便番号")
    set_column_comment(:local_people, :home_country, "出身国")
    set_column_comment(:local_people, :photo_url, "写真のURL")
    set_column_comment(:local_people, :public_flag, "公開フラグ")
    set_column_comment(:local_people, :in_city_flag, "市内・市外区分")
    set_column_comment(:local_people, :shelter_name, "避難所")
    set_column_comment(:local_people, :refuge_status, "避難状況")
    set_column_comment(:local_people, :refuge_reason, "避難理由")
    set_column_comment(:local_people, :shelter_entry_date, "入所年月日")
    set_column_comment(:local_people, :shelter_leave_date, "退所年月日")
    set_column_comment(:local_people, :next_place, "退所先")
    set_column_comment(:local_people, :next_place_phone, "退所先電話番号")
    set_column_comment(:local_people, :injury_flag, "負傷")
    set_column_comment(:local_people, :injury_condition, "負傷内容")
    set_column_comment(:local_people, :allergy_flag, "アレルギー")
    set_column_comment(:local_people, :allergy_cause, "アレルギー物質")
    set_column_comment(:local_people, :pregnancy, "妊婦")
    set_column_comment(:local_people, :baby, "乳幼児")
    set_column_comment(:local_people, :upper_care_level_three, "要介護度3以上")
    set_column_comment(:local_people, :elderly_alone, "一人暮らし高齢者（65歳以上）")
    set_column_comment(:local_people, :elderly_couple, "高齢者世帯（夫婦共に65歳以上）")
    set_column_comment(:local_people, :bedridden_elderly, "寝たきり高齢者")
    set_column_comment(:local_people, :elderly_dementia, "認知症高齢者")
    set_column_comment(:local_people, :rehabilitation_certificate, "療育手帳所持者")
    set_column_comment(:local_people, :physical_disability_certificate, "身体障害者手帳所持者")
    set_column_comment(:local_people, :status, "状況")
    set_column_comment(:local_people, :last_known_location, "最後に見かけた場所")
    set_column_comment(:local_people, :approved_by, "承認者")
    set_column_comment(:local_people, :approved_at, "承認日時")
    set_column_comment(:local_people, :created_by, "登録者")
    set_column_comment(:local_people, :updated_by, "更新者")
    set_column_comment(:local_people, :created_at, "登録日時")
    set_column_comment(:local_people, :updated_at, "更新日時")
  end

  def down
  end
end
