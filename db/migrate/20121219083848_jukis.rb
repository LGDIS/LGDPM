# -*- coding:utf-8 -*-
class Jukis < ActiveRecord::Migration
  def up
    create_table :jukis, :force => true do |t|
      # 識別番号
      t.column "id_number", :string
      # 世帯番号
      t.column "household_number", :string
      # 住民種別
      t.column "residents_type", :string
      # 住民状態
      t.column "residents_state", :string
      # 住民票コード
      t.column "residents_code", :string
      # 氏名（姓）
      t.column "family_name", :string
      # 氏名（名）
      t.column "given_name", :string
      # 氏名カナ（姓）
      t.column "alternate_family_name", :string
      # 氏名カナ（名）
      t.column "alternate_given_name", :string
      # 性別
      t.column "sex", :string
      # 生年月日：年号
      t.column "year_number", :string
      # 生年月日
      t.column "date_of_birth", :date
      # 続柄1
      t.column "relation1", :string
      # 続柄2
      t.column "relation2", :string
      # 続柄3
      t.column "relation3", :string
      # 続柄4
      t.column "relation4", :string
      # 世帯主氏名（姓）
      t.column "household_family_name", :string
      # 世帯主氏名（名）
      t.column "household_given_name", :string
      # 世帯主氏名カナ（姓）
      t.column "household_alternate_family_name", :string
      # 世帯主氏名カナ（名）
      t.column "household_alternate_given_name", :string
      # 現住所：住所コード
      t.column "address_code", :string
      # 現住所：住所
      t.column "address", :string
      # 現住所：方書
      t.column "building_name", :string
      # 現住所：郵便番号
      t.column "postal_code", :string
      # 前住所：住所コード
      t.column "former_address_code", :string
      # 前住所：住所
      t.column "former_address", :string
      # 前住所：方書
      t.column "former_building_name", :string
      # 前住所：郵便番号
      t.column "former_postal_code", :string
      # 転出先：住所コード
      t.column "new_address_code", :string
      # 転出先：住所
      t.column "new_address", :string
      # 転出先：方書
      t.column "new_building_name", :string
      # 転出先：郵便番号
      t.column "new_postal_code", :string
      # 転出先区分
      t.column "new_address_division", :string
      # 本籍
      t.column "domicile", :string
      # 本籍住所コード
      t.column "domicile_code", :string
      # 筆頭者
      t.column "family_head", :string
      # 住民となった情報：異動年月日
      t.column "became_change_date", :date
      # 住民となった情報：届出年月日
      t.column "became_report_date", :date
      # 住民となった情報：増異動事由
      t.column "became_change_reason", :string
      # 住民を定めた情報：異動年月日
      t.column "decided_change_date", :date
      # 住民を定めた情報：届出年月日
      t.column "decided_report_date", :date
      # 住民を定めた情報：異動事由
      t.column "decided_change_reason", :string
      # 住民でなくなった情報：異動年月日
      t.column "lost_change_date", :date
      # 住民でなくなった情報：届出年月日
      t.column "lost_report_date", :date
      # 住民でなくなった情報：減異動事由
      t.column "lost_change_reason", :string
      # 異動年月日
      t.column "change_date", :datetime
      # 独自領域
      t.column "original_area", :string
      # 異動中区分
      t.column "change_division", :string
      # 異動事由
      t.column "change_reason", :string
      # 登録者
      t.column "created_by", :string
      # 更新者
      t.column "updated_by", :string
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
    set_column_comment(:jukis, :year_number, "生年月日：年号")
    set_column_comment(:jukis, :date_of_birth, "生年月日")
    set_column_comment(:jukis, :relation1, "続柄1")
    set_column_comment(:jukis, :relation2, "続柄2")
    set_column_comment(:jukis, :relation3, "続柄3")
    set_column_comment(:jukis, :relation4, "続柄4")
    set_column_comment(:jukis, :household_family_name, "世帯主氏名（姓）")
    set_column_comment(:jukis, :household_given_name, "世帯主氏名（名）")
    set_column_comment(:jukis, :household_alternate_family_name, "世帯主氏名カナ（姓）")
    set_column_comment(:jukis, :household_alternate_given_name, "世帯主氏名カナ（名）")
    set_column_comment(:jukis, :address_code, "現住所：住所コード")
    set_column_comment(:jukis, :address, "現住所：住所")
    set_column_comment(:jukis, :building_name, "現住所：方書")
    set_column_comment(:jukis, :postal_code, "現住所：郵便番号")
    set_column_comment(:jukis, :former_address_code, "前住所：住所コード")
    set_column_comment(:jukis, :former_address, "前住所：住所")
    set_column_comment(:jukis, :former_building_name, "前住所：方書")
    set_column_comment(:jukis, :former_postal_code, "前住所：郵便番号")
    set_column_comment(:jukis, :new_address_code, "転出先：住所コード")
    set_column_comment(:jukis, :new_address, "転出先：住所")
    set_column_comment(:jukis, :new_building_name, "転出先：方書")
    set_column_comment(:jukis, :new_postal_code, "転出先：郵便番号")
    set_column_comment(:jukis, :new_address_division, "転出先区分")
    set_column_comment(:jukis, :domicile, "本籍")
    set_column_comment(:jukis, :domicile_code, "本籍住所コード")
    set_column_comment(:jukis, :family_head, "筆頭者")
    set_column_comment(:jukis, :became_change_date, "住民となった情報：異動年月日")
    set_column_comment(:jukis, :became_report_date, "住民となった情報：届出年月日")
    set_column_comment(:jukis, :became_change_reason, "住民となった情報：増異動事由")
    set_column_comment(:jukis, :decided_change_date, "住民を定めた情報：異動年月日")
    set_column_comment(:jukis, :decided_report_date, "住民を定めた情報：届出年月日")
    set_column_comment(:jukis, :decided_change_reason, "住民を定めた情報：異動事由")
    set_column_comment(:jukis, :lost_change_date, "住民でなくなった情報：異動年月日")
    set_column_comment(:jukis, :lost_report_date, "住民でなくなった情報：届出年月日")
    set_column_comment(:jukis, :lost_change_reason, "住民でなくなった情報：減異動事由")
    set_column_comment(:jukis, :change_date, "異動年月日")
    set_column_comment(:jukis, :original_area, "独自領域")
    set_column_comment(:jukis, :change_division, "異動中区分")
    set_column_comment(:jukis, :change_reason, "異動事由")
    set_column_comment(:jukis, :created_by, "登録者")
    set_column_comment(:jukis, :updated_by, "更新者")
    set_column_comment(:jukis, :created_at, "登録日時")
    set_column_comment(:jukis, :updated_at, "更新日時")
  end

  def down
  end
end
