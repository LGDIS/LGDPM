# -*- coding:utf-8 -*-
class Jukis < ActiveRecord::Migration
  def up
    create_table :jukis, :force => true do |t|
      # 識別番号
      t.column "id_number", :string, :limit => 500
      # 世帯番号
      t.column "household_number", :string, :limit => 500
      # 住民種別
      t.column "residents_type", :string, :limit => 500
      # 住民状態
      t.column "residents_state", :string, :limit => 500
      # 住民票コード
      t.column "residents_code", :string, :limit => 500
      # 氏名（姓）
      t.column "family_name", :string, :limit => 500
      # 氏名（名）
      t.column "given_name", :string, :limit => 500
      # 氏名カナ（姓）
      t.column "alternate_family_name", :string, :limit => 500
      # 氏名カナ（名）
      t.column "alternate_given_name", :string, :limit => 500
      # 性別
      t.column "sex", :string, :limit => 1
      # 年齢
      t.column "age", :string, :limit => 500
      # 生年月日
      t.column "date_of_birth", :date
      # 都道府県
      t.column "home_state", :string, :limit => 500
      # 市区町村
      t.column "home_city", :string, :limit => 500
      # 町名
      t.column "home_street", :string, :limit => 500
      # 番地
      t.column "house_number", :string, :limit => 500
      # 郵便番号
      t.column "home_postal_code", :string, :limit => 500
      # 負傷
      t.column "injury_flag", :string, :limit => 1
      # 負傷内容
      t.column "injury_condition", :text
      # アレルギー
      t.column "allergy_flag", :string, :limit => 1
      # アレルギー物質
      t.column "allergy_cause", :text
      # 妊婦
      t.column "pregnancy", :string, :limit => 1
      # 乳幼児
      t.column "baby", :string, :limit => 1
      # 要介護度
      t.column "upper_care_level_three", :string, :limit => 2
      # 一人暮らし高齢者（65歳以上）
      t.column "elderly_alone", :string, :limit => 1
      # 高齢者世帯（夫婦共に65歳以上）
      t.column "elderly_couple", :string, :limit => 1
      # 寝たきり高齢者
      t.column "bedridden_elderly", :string, :limit => 1
      # 認知症高齢者
      t.column "elderly_dementia", :string, :limit => 1
      # 療育手帳所持者
      t.column "rehabilitation_certificate", :string, :limit => 2
      # 身体障害者手帳所持者
      t.column "physical_disability_certificate", :string, :limit => 1
      # 本籍
      t.column "domicile", :string, :limit => 500
      # 筆頭者
      t.column "family_head", :string, :limit => 500
      # 登録者
      t.column "created_by", :string, :limit => 100
      # 更新者
      t.column "updated_by", :string, :limit => 100
      # 登録日時・更新日時
      t.timestamps
    end
    
    set_column_comment(:jukis, :id_number, "識別番号")
    set_column_comment(:jukis, :household_number, "世帯番号")
    set_column_comment(:jukis, :residents_type, "住民種別")
    set_column_comment(:jukis, :residents_state, "住民状態")
    set_column_comment(:jukis, :residents_code, "住民票コード")
    set_column_comment(:jukis, :family_name, "氏名（姓）")
    set_column_comment(:jukis, :given_name, "氏名（名）")
    set_column_comment(:jukis, :alternate_family_name, "氏名カナ（姓）")
    set_column_comment(:jukis, :alternate_given_name, "氏名カナ（名）")
    set_column_comment(:jukis, :sex, "性別")
    set_column_comment(:jukis, :age, "年齢")
    set_column_comment(:jukis, :date_of_birth, "生年月日")
    set_column_comment(:jukis, :home_state, "都道府県")
    set_column_comment(:jukis, :home_city, "市区町村")
    set_column_comment(:jukis, :home_street, "町名")
    set_column_comment(:jukis, :house_number, "番地")
    set_column_comment(:jukis, :home_postal_code, "郵便番号")
    set_column_comment(:jukis, :injury_flag, "負傷")
    set_column_comment(:jukis, :injury_condition, "負傷内容")
    set_column_comment(:jukis, :allergy_flag, "アレルギー")
    set_column_comment(:jukis, :allergy_cause, "アレルギー物質")
    set_column_comment(:jukis, :pregnancy, "妊婦")
    set_column_comment(:jukis, :baby, "乳幼児")
    set_column_comment(:jukis, :upper_care_level_three, "要介護度")
    set_column_comment(:jukis, :elderly_alone, "一人暮らし高齢者（65歳以上）")
    set_column_comment(:jukis, :elderly_couple, "高齢者世帯（夫婦共に65歳以上）")
    set_column_comment(:jukis, :bedridden_elderly, "寝たきり高齢者")
    set_column_comment(:jukis, :elderly_dementia, "認知症高齢者")
    set_column_comment(:jukis, :rehabilitation_certificate, "療育手帳所持者")
    set_column_comment(:jukis, :physical_disability_certificate, "身体障害者手帳所持者")
    set_column_comment(:jukis, :domicile, "本籍")
    set_column_comment(:jukis, :family_head, "筆頭者")
    set_column_comment(:jukis, :created_by, "登録者")
    set_column_comment(:jukis, :updated_by, "更新者")
    set_column_comment(:jukis, :created_at, "登録日時")
    set_column_comment(:jukis, :updated_at, "更新日時")
  end

  def down
  end
end
