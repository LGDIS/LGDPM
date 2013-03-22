# -*- coding:utf-8 -*-
class Evacuees < ActiveRecord::Migration
  def up
    create_table :evacuees, :force => true do |t|
      t.column "lgdpf_person_id", :integer
      t.column "person_record_id", :string, :limit => 500
      t.column "family_name", :string, :limit => 500
      t.column "given_name", :string, :limit => 500
      t.column "alternate_family_name", :string, :limit => 500
      t.column "alternate_given_name", :string, :limit => 500
      t.column "date_of_birth", :date
      t.column "sex", :string, :limit => 1
      t.column "age", :string, :limit => 500
      t.column "home_postal_code", :string, :limit => 500
      t.column "in_city_flag", :string, :limit => 1
      t.column "home_state", :string, :limit => 500
      t.column "home_city", :string, :limit => 500
      t.column "home_street", :string, :limit => 500
      t.column "house_number", :string, :limit => 500
      t.column "shelter_name", :string, :limit => 20
      t.column "refuge_status", :string, :limit => 1
      t.column "refuge_reason", :text
      t.column "shelter_entry_date", :date
      t.column "shelter_leave_date", :date
      t.column "next_place", :string, :limit => 100
      t.column "next_place_phone", :string, :limit => 20
      t.column "injury_flag", :string, :limit => 1
      t.column "injury_condition", :text
      t.column "allergy_flag", :string, :limit => 1
      t.column "allergy_cause", :text
      t.column "pregnancy", :string, :limit => 1
      t.column "baby", :string, :limit => 1
      t.column "upper_care_level_three", :string, :limit => 2
      t.column "elderly_alone", :string, :limit => 1
      t.column "elderly_couple", :string, :limit => 1
      t.column "bedridden_elderly", :string, :limit => 1
      t.column "elderly_dementia", :string, :limit => 1
      t.column "rehabilitation_certificate", :string, :limit => 2
      t.column "physical_disability_certificate", :string, :limit => 1
      t.column "juki_status", :integer
      t.column "note", :text
      t.column "family_well", :string, :limit => 1
      t.column "juki_number", :string, :limit => 500
      t.column "household_number", :string, :limit => 500
      t.column "area", :string, :limit => 255
      t.column "source_name", :string, :limit => 1
      t.column "pf_export_flag", :string, :limit => 1
      t.column "public_flag", :integer
      t.column "created_by", :string, :limit => 100
      t.column "updated_by", :string, :limit => 100
      t.column "deleted_at", :timestamp
      t.timestamps
    end

    set_column_comment(:evacuees, :lgdpf_person_id, "LGDPFのperson_id")
    set_column_comment(:evacuees, :person_record_id, "GooglePersonFinderのperson_id")
    set_column_comment(:evacuees, :family_name, "氏名（姓）")
    set_column_comment(:evacuees, :given_name, "氏名（名）")
    set_column_comment(:evacuees, :alternate_family_name, "氏名カナ（姓）")
    set_column_comment(:evacuees, :alternate_given_name, "氏名カナ（名）")
    set_column_comment(:evacuees, :date_of_birth, "生年月日")
    set_column_comment(:evacuees, :sex, "性別")
    set_column_comment(:evacuees, :age, "年齢")
    set_column_comment(:evacuees, :home_postal_code, "郵便番号")
    set_column_comment(:evacuees, :in_city_flag, "市内・市外区分")
    set_column_comment(:evacuees, :home_state, "都道府県")
    set_column_comment(:evacuees, :home_city, "市区町村")
    set_column_comment(:evacuees, :home_street, "町名")
    set_column_comment(:evacuees, :house_number, "番地")
    set_column_comment(:evacuees, :shelter_name, "避難所")
    set_column_comment(:evacuees, :refuge_status, "避難状況")
    set_column_comment(:evacuees, :refuge_reason, "避難理由")
    set_column_comment(:evacuees, :shelter_entry_date, "入所年月日")
    set_column_comment(:evacuees, :shelter_leave_date, "退所年月日")
    set_column_comment(:evacuees, :next_place, "退所先")
    set_column_comment(:evacuees, :next_place_phone, "退所先電話番号")
    set_column_comment(:evacuees, :injury_flag, "負傷")
    set_column_comment(:evacuees, :injury_condition, "負傷内容")
    set_column_comment(:evacuees, :allergy_flag, "アレルギー")
    set_column_comment(:evacuees, :allergy_cause, "アレルギー物質")
    set_column_comment(:evacuees, :pregnancy, "妊婦")
    set_column_comment(:evacuees, :baby, "乳幼児")
    set_column_comment(:evacuees, :upper_care_level_three, "要介護度3以上")
    set_column_comment(:evacuees, :elderly_alone, "一人暮らし高齢者（65歳以上）")
    set_column_comment(:evacuees, :elderly_couple, "高齢者世帯（夫婦共に65歳以上）")
    set_column_comment(:evacuees, :bedridden_elderly, "寝たきり高齢者")
    set_column_comment(:evacuees, :elderly_dementia, "認知症高齢者")
    set_column_comment(:evacuees, :rehabilitation_certificate, "療育手帳所持者")
    set_column_comment(:evacuees, :physical_disability_certificate, "身体障害者手帳所持者")
    set_column_comment(:evacuees, :juki_status, "住基ステータス")
    set_column_comment(:evacuees, :note, "備考")
    set_column_comment(:evacuees, :family_well, "家族も無事")
    set_column_comment(:evacuees, :juki_number, "住基番号")
    set_column_comment(:evacuees, :household_number, "世帯番号")
    set_column_comment(:evacuees, :area, "地区")
    set_column_comment(:evacuees, :source_name, "情報ソース")
    set_column_comment(:evacuees, :pf_export_flag, "PF出力")
    set_column_comment(:evacuees, :public_flag, "公開フラグ")
    set_column_comment(:evacuees, :created_by, "登録者")
    set_column_comment(:evacuees, :updated_by, "更新者")
    set_column_comment(:evacuees, :deleted_at, "削除日時")
    set_column_comment(:evacuees, :created_at, "登録日時")
    set_column_comment(:evacuees, :updated_at, "更新日時")
  end

  def down
  end
end
