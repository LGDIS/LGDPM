# -*- coding:utf-8 -*-
class Evacuees < ActiveRecord::Migration
  def up
    create_table :evacuees, :force => true do |t|
      t.column "family_name", :string
      t.column "given_name", :string
      t.column "alternate_family_name", :string
      t.column "alternate_given_name", :string
      t.column "date_of_birth", :date
      t.column "sex", :integer
      t.column "home_postal_code", :string
      t.column "in_city_flag", :integer
      t.column "home_state", :string
      t.column "home_city", :string
      t.column "home_street", :string
      t.column "house_number", :string
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
      t.column "juki_status", :integer
      t.column "note", :string
      t.column "linked_by", :string
      t.column "linked_at", :datetime
      t.column "created_by", :string
      t.column "updated_by", :string
      t.column "deleted_at", :timestamp
      t.timestamps
    end

    set_column_comment(:evacuees, :family_name, "氏名（姓）")
    set_column_comment(:evacuees, :given_name, "氏名（名）")
    set_column_comment(:evacuees, :alternate_family_name, "氏名カナ（姓）")
    set_column_comment(:evacuees, :alternate_given_name, "氏名カナ（名）")
    set_column_comment(:evacuees, :date_of_birth, "生年月日")
    set_column_comment(:evacuees, :sex, "性別")
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
    set_column_comment(:evacuees, :linked_by, "連携者")
    set_column_comment(:evacuees, :linked_at, "連携日時")
    set_column_comment(:evacuees, :created_by, "登録者")
    set_column_comment(:evacuees, :updated_by, "更新者")
    set_column_comment(:evacuees, :deleted_at, "削除日時")
    set_column_comment(:evacuees, :created_at, "登録日時")
    set_column_comment(:evacuees, :updated_at, "更新日時")
  end

  def down
  end
end
