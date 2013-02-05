# -*- coding:utf-8 -*-
class Juki < ActiveRecord::Base
  attr_accessible :id_number, :household_number, :residents_type,
    :residents_state, :residents_code, :family_name, :given_name,
    :alternate_family_name, :alternate_given_name, :sex, :year_number,
    :date_of_birth, :relation1, :relation2, :relation3, :relation4,
    :household_family_name, :household_given_name, :household_alternate_family_name,
    :household_alternate_given_name, :address_code, :address, :building_name,
    :postal_code, :former_address_code, :former_address, :former_building_name,
    :former_postal_code, :new_address_code, :new_address, :new_building_name,
    :new_postal_code, :new_address_division, :domicile, :domicile_code,
    :family_head, :became_change_date, :became_report_date, :became_change_reason,
    :decided_change_date, :decided_report_date, :decided_change_reason,
    :lost_change_date, :lost_report_date, :lost_change_reason, :change_date,
    :original_area, :change_division, :change_reason, :created_by, :updated_by

  validates :id_number,
              :length => {:maximum => 15}
  validates :household_number,
              :length => {:maximum => 15}
  validates :residents_type,
              :length => {:maximum => 1}
  validates :residents_state,
              :length => {:maximum => 1}
  validates :residents_code,
              :length => {:maximum => 11}
  validates :family_name,
              :length => {:maximum => 100}
  validates :given_name,
              :length => {:maximum => 100}
  validates :alternate_family_name,
              :length => {:maximum => 100}
  validates :alternate_given_name,
              :length => {:maximum => 100}
  validates :sex,
              :length => {:maximum => 1}
  validates :year_number,
              :length => {:maximum => 2}
  validates :date_of_birth, :date => true
  validates :relation1,
              :length => {:maximum => 2}
  validates :relation2,
              :length => {:maximum => 2}
  validates :relation3,
              :length => {:maximum => 2}
  validates :relation4,
              :length => {:maximum => 2}
  validates :household_family_name,
              :length => {:maximum => 100}
  validates :household_given_name,
              :length => {:maximum => 100}
  validates :household_alternate_family_name,
              :length => {:maximum => 100}
  validates :household_alternate_given_name,
              :length => {:maximum => 100}
  validates :address_code,
              :length => {:maximum => 30}
  validates :address,
              :length => {:maximum => 100}
  validates :building_name,
              :length => {:maximum => 150}
  validates :postal_code,
              :length => {:maximum => 10}
  validates :former_address_code,
              :length => {:maximum => 30}
  validates :former_address,
              :length => {:maximum => 100}
  validates :former_building_name,
              :length => {:maximum => 150}
  validates :former_postal_code,
              :length => {:maximum => 10}
  validates :new_address_code,
              :length => {:maximum => 30}
  validates :new_address,
              :length => {:maximum => 100}
  validates :new_building_name,
              :length => {:maximum => 150}
  validates :new_postal_code,
              :length => {:maximum => 10}
  validates :new_address_division,
              :length => {:maximum => 1}
  validates :domicile,
              :length => {:maximum => 100}
  validates :domicile_code,
              :length => {:maximum => 30}
  validates :family_head,
              :length => {:maximum => 100}
  validates :became_change_date, :date => true
  validates :became_report_date, :date => true
  validates :became_change_reason,
              :length => {:maximum => 2}
  validates :decided_change_date, :date => true
  validates :decided_report_date, :date => true
  validates :decided_change_reason,
              :length => {:maximum => 2}
  validates :lost_change_date, :date => true
  validates :lost_report_date, :date => true
  validates :lost_change_reason,
              :length => {:maximum => 2}
  validates :change_date, :time => true
  validates :original_area,
              :length => {:maximum => 50}
  validates :change_division,
              :length => {:maximum => 1}
  validates :change_reason,
              :length => {:maximum => 2}
  validates :created_by,
              :length => {:maximum => 100}
  validates :updated_by,
              :length => {:maximum => 100}

  # 避難者住基マッチング検索処理
  # ==== Args
  # ==== Return
  # ==== Raise
  def self.find_for_match(evacuee)
    # TODO 仕様変更対応
    # condition_array = []
    juki_table = Juki.arel_table
    result = Juki.select("*")
    
    # 氏名カナ（姓）
    result = result.where(juki_table[:alternate_family_name].eq(evacuee.alternate_family_name)) if evacuee.alternate_family_name.present?
    # 氏名カナ（名）
    result = result.where(juki_table[:alternate_given_name].eq(evacuee.alternate_given_name)) if evacuee.alternate_given_name.present?
    # 生年月日
    result = result.where(juki_table[:date_of_birth].eq(evacuee.date_of_birth)) if evacuee.date_of_birth.present?
    # 性別
    result = result.where(juki_table[:sex].eq(evacuee.sex)) if evacuee.sex.present?
    # 都道府県
    result = result.where(juki_table[:address].matches("%#{evacuee.home_state}%")) if evacuee.home_state.present?
    # 市区町村
    result = result.where(juki_table[:address].matches("%#{evacuee.home_city}%")) if evacuee.home_city.present?
    # 町名
    result = result.where(juki_table[:address].matches("%#{evacuee.home_street}%")) if evacuee.home_street.present?
    
    return result
    
    # 氏名カナ（姓）
    # condition_array << jukis[:alternate_family_name].eq(evacuee.alternate_family_name) if evacuee.alternate_family_name.present?
    # 氏名カナ（名）
    # condition_array << jukis[:alternate_given_name].eq(evacuee.alternate_given_name) if evacuee.alternate_given_name.present?
    # 生年月日
    # condition_array << jukis[:date_of_birth].eq(evacuee.date_of_birth) if evacuee.date_of_birth.present?
    # 性別
    # condition_array << jukis[:sex].eq(evacuee.sex) if evacuee.sex.present?
    # 都道府県
    # condition_array << jukis[:address].matches("%#{evacuee.home_state}%") if evacuee.home_state.present?
    # 市区町村
    # condition_array << jukis[:address].matches("%#{evacuee.home_city}%") if evacuee.home_city.present?
    # 町名
    # condition_array << jukis[:address].matches("%#{evacuee.home_street}%") if evacuee.home_street.present?
    
    # i = 1
    # length = (condition_array.blank? ? 0 : condition_array.size)
    #
    # while (i <= length) do
      # condition_array.combination(i).each do |condition|
        # result = self.where(condition.first)
        # condition.delete_at(0)
        # condition.each{|con| result = result.where(con) } if condition.present?
        # return result if result.present? && result.size == 1
      # end
      # i += 1
    # end
    #
    # return nil
  end
  
  # 住基情報取込処理
  # ==== Args
  # _file_ :: 住基CSVファイル
  # _user_ :: 実行ユーザ
  # ==== Return
  # ==== Raise
  def self.import(file, user)
    require 'csv'
    number, error_msgs = 0, []
    
    ActiveRecord::Base.transaction do
      # 住基情報をすべて削除する
      Juki.destroy_all
      # 住基情報の登録
      CSV.parse(file) do |row|
        begin
          # 取込件数
          number += 1
          # 列数チェック
          raise I18n.t("activerecord.errors.messages.invalid_column") unless row.length == 64
          juki = Juki.new
          juki = juki.exec_insert(row)
          # バリデーションエラーの場合メッセージを出力
          unless juki.save
            juki.errors.full_messages.each do |msg|
              error_msgs << I18n.t("activerecord.errors.messages.import_error", :count => number, :message => msg)
            end
          end
        rescue => e
          error_msgs << I18n.t("activerecord.errors.messages.import_error", :count => number, :message => e)
        end # <- begin
      end # <- CSV.parse
      
      # エラーが存在する場合、例外を発生させる  
      if error_msgs.present?
        logger ||= ActiveSupport::BufferedLogger.new(File.join(Rails.root, 'log', 'juki.log'))
        error_msgs.each{|m| logger.error m }
        raise
      end
      
    end # <- ActiveRecord::Base.transaction
  ensure
    # 住基情報取込履歴の登録
    juki_history = JukiHistory.new
    juki_history.number     = number
    juki_history.status     = (error_msgs.blank? ? JukiHistory::STATUS_NORMAL : JukiHistory::STATUS_ERROR)
    juki_history.created_by = user
    juki_history.save!
  end
  
  # 住基情報編集処理
  # 引数のrowオブジェクトを基に各項目を編集する
  # ==== Args
  # _row_ :: 住基情報配列
  # ==== Return
  # 住基オブジェクト
  # ==== Raise
  def exec_insert(row)
    # 識別番号
    self.id_number = row[0]
    # 世帯番号
    self.household_number = row[1]
    # 住民種別
    self.residents_type = row[2]
    # 住民状態
    self.residents_state = row[3]
    # 住民票コード
    self.residents_code = row[4]
    # 氏名（姓）
    self.family_name = row[5].split("　")[0]
    # 氏名（名）
    self.given_name = row[5].split("　")[1]
    # 氏名カナ（姓）
    self.alternate_family_name = row[6].split("　")[0]
    # 氏名カナ（名）
    self.alternate_given_name = row[6].split("　")[1]
    # 性別
    self.sex = row[7]
    # 生年月日：年号
    self.year_number = row[8]
    # 生年月日
    self.date_of_birth = Date.new(row[9].to_i, row[10].to_i, row[11].to_i).to_s
    # 続柄1
    self.relation1 = row[12]
    # 続柄2
    self.relation2 = row[13]
    # 続柄3
    self.relation3 = row[14]
    # 続柄4
    self.relation4 = row[15]
    # 世帯主氏名（姓）
    self.household_family_name = row[16].split("　")[0]
    # 世帯主氏名（名）
    self.household_given_name = row[16].split("　")[1]
    # 世帯主氏名カナ（姓）
    self.household_alternate_family_name = row[17].split("　")[0]
    # 世帯主氏名カナ（名）
    self.household_alternate_given_name = row[17].split("　")[1]
    # 現住所：住所コード
    self.address_code = row[18]
    # 現住所：住所
    self.address = row[19]
    # 現住所：方書
    self.building_name = row[20]
    # 現住所：郵便番号
    self.postal_code = row[21]
    # 前住所：住所コード
    self.former_address_code = row[22]
    # 前住所：住所
    self.former_address = row[23]
    # 前住所：方書
    self.former_building_name = row[24]
    # 前住所：郵便番号
    self.former_postal_code = row[25]
    # 転出先：住所コード
    self.new_address_code = row[26]
    # 転出先：住所
    self.new_address = row[27]
    # 転出先：方書
    self.new_building_name = row[28]
    # 転出先：郵便番号
    self.new_postal_code = row[29]
    # 転出先区分
    self.new_address_division = row[30]
    # 本籍
    self.domicile = row[31]
    # 本籍住所コード
    self.domicile_code = row[32]
    # 筆頭者
    self.family_head = row[33]
    # 住民となった情報：異動年月日
    self.became_change_date = Date.new(row[34].to_i, row[35].to_i, row[36].to_i).to_s
    # 住民となった情報：届出年月日
    self.became_report_date = Date.new(row[37].to_i, row[38].to_i, row[39].to_i).to_s
    # 住民となった情報：増異動事由
    self.became_change_reason = row[40]
    # 住民を定めた情報：異動年月日
    self.decided_change_date = Date.new(row[41].to_i, row[42].to_i, row[43].to_i).to_s
    # 住民を定めた情報：届出年月日
    self.decided_report_date = Date.new(row[44].to_i, row[45].to_i, row[46].to_i).to_s
    # 住民を定めた情報：異動事由
    self.decided_change_reason = row[47]
    # 住民でなくなった情報：異動年月日
    self.lost_change_date = Date.new(row[48].to_i, row[49].to_i, row[50].to_i).to_s
    # 住民でなくなった情報：届出年月日
    self.lost_report_date = Date.new(row[51].to_i, row[52].to_i, row[53].to_i).to_s
    # 住民でなくなった情報：減異動事由
    self.lost_change_reason = row[54]
    # 異動年月日
    self.change_date = DateTime.new(row[55].to_i, row[56].to_i, row[57].to_i, row[58].to_i, row[59].to_i, row[60].to_i).strftime("%Y/%m/%d %H:%M:%S")
    # 独自領域
    self.original_area = row[61]
    # 異動中区分
    self.change_division = row[62]
    # 異動事由
    self.change_reason = row[63]
    # 登録者
    # self.created_by = current_user
    # 更新者
    # self.updated_by = current_user
    
    return self
  end
end
