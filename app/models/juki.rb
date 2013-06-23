# -*- coding:utf-8 -*-
class Juki < ActiveRecord::Base
  attr_accessible :id_number,:household_number,:residents_type,:residents_state,
    :residents_code,:family_name,:given_name,:alternate_family_name,:alternate_given_name,:sex,:age,
    :date_of_birth,:home_state,:home_city,:home_street,:house_number,:home_postal_code,:injury_flag,
    :injury_condition,:allergy_flag,:allergy_cause,:pregnancy,:baby,:upper_care_level_three,:elderly_alone,
    :elderly_couple,:bedridden_elderly,:elderly_dementia,:rehabilitation_certificate,
    :physical_disability_certificate,:domicile,:family_head,:created_by,:updated_by
    
  validates :id_number, :length => {:maximum => 500}
  validates :household_number, :length => {:maximum => 500}
  validates :residents_type, :length => {:maximum => 500}
  validates :residents_state, :length => {:maximum => 500}
  validates :residents_code, :length => {:maximum => 500}
  validates :family_name, :length => {:maximum => 500}
  validates :given_name, :length => {:maximum => 500}
  validates :alternate_family_name, :length => {:maximum => 500}
  validates :alternate_given_name, :length => {:maximum => 500}
  validates :sex, :length => {:maximum => 1}
  validates :age, :length => {:maximum => 500}
  validates :date_of_birth, :date => true
  validates :home_state, :length => {:maximum => 500}
  validates :home_city, :length => {:maximum => 500}
  validates :home_street, :length => {:maximum => 500}
  validates :house_number, :length => {:maximum => 500}
  validates :home_postal_code, :length => {:maximum => 500}
  validates :injury_flag, :length => {:maximum => 1}
  validates :allergy_flag, :length => {:maximum => 1}
  validates :pregnancy, :length => {:maximum => 1}
  validates :baby, :length => {:maximum => 1}
  validates :upper_care_level_three, :length => {:maximum => 2}
  validates :elderly_alone, :length => {:maximum => 1}
  validates :elderly_couple, :length => {:maximum => 1}
  validates :bedridden_elderly, :length => {:maximum => 1}
  validates :elderly_dementia, :length => {:maximum => 1}
  validates :rehabilitation_certificate, :length => {:maximum => 2}
  validates :physical_disability_certificate, :length => {:maximum => 1}
  validates :domicile, :length => {:maximum => 500}
  validates :family_head, :length => {:maximum => 500}
  validates :created_by, :length => {:maximum => 100}
  validates :updated_by, :length => {:maximum => 100}
  
  # 避難者住基マッチング検索処理
  # ==== Args
  # _evacuee_ :: Evacueeオブジェクト
  # _pattern_ :: 検索対象項目の配列
  # ==== Return
  # ==== Raise
  def self.find_for_match(evacuee, pattern)
    juki_table = Juki.arel_table
    result = Juki.scoped
    
    # 氏名（姓）
    if pattern.include?(:family_name)
      result = result.where(juki_table[:family_name].eq(evacuee.family_name))
    end
    # 氏名（名）
    if pattern.include?(:given_name)
      result = result.where(juki_table[:given_name].eq(evacuee.given_name))
    end
    # 氏名カナ（姓）
    if pattern.include?(:alternate_family_name)
      result = result.where(juki_table[:alternate_family_name].eq(evacuee.alternate_family_name))
    end
    # 氏名カナ（名）
    if pattern.include?(:alternate_given_name)
      result = result.where(juki_table[:alternate_given_name].eq(evacuee.alternate_given_name))
    end
    # 生年月日
    if pattern.include?(:date_of_birth)
      result = result.where(juki_table[:date_of_birth].eq(evacuee.date_of_birth))
    end
    # 性別
    if pattern.include?(:sex)
      result = result.where(juki_table[:sex].eq(evacuee.sex))
    end
    # 都道府県
    if pattern.include?(:home_state)
      @state = State.hash_for_table
      result = result.where(juki_table[:home_state].matches("%#{@state[evacuee.home_state]}%"))
    end
    # 市区町村
    if pattern.include?(:home_city)
      result = result.where(juki_table[:home_city].matches("%#{evacuee.home_city}%"))
    end
    # 町名
    if pattern.include?(:home_street)
      result = result.where(juki_table[:home_street].matches("%#{evacuee.home_street}%"))
    end
    
    return result
  end
  
  # 家族検索処理
  # ==== Args
  # _evacuee_ :: Evacueeオブジェクト
  # ==== Return
  # ==== Raise
  def self.find_for_family(evacuee)
    t = Juki.arel_table
    myself = self.where(t[:id_number].eq(evacuee.juki_number)).first
    if myself.present?
      # 筆頭者が同じ人物は家族として判断する
      return families = self.where(t[:family_head].eq(myself.family_head)).where(t[:id].not_eq(myself.id))
    else
      return []
    end
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
          raise I18n.t("activerecord.errors.messages.invalid_column") unless row.length == 32
          juki = Juki.new
          juki = juki.exec_insert(row, user)
          # バリデーションエラーの場合メッセージを出力
          unless juki.save(:validate => SETTINGS["juki_validates_enable"])
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
  # _user_ :: ユーザ名
  # ==== Return
  # 住基オブジェクト
  # ==== Raise
  def exec_insert(row, user)
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
    self.family_name = row[5]
    # 氏名（名）
    self.given_name = row[6]
    # 氏名カナ（姓）
    self.alternate_family_name = row[7]
    # 氏名カナ（名）
    self.alternate_given_name = row[8]
    # 性別
    self.sex = row[9]
    # 年齢
    self.age = row[10]
    # 生年月日
    self.date_of_birth = row[11]
    # 都道府県
    self.home_state = row[12]
    # 市区町村
    self.home_city = row[13]
    # 町名
    self.home_street = row[14]
    # 番地
    self.house_number = row[15]
    # 郵便番号
    self.home_postal_code = row[16]
    # 負傷
    self.injury_flag = row[17]
    # 負傷内容
    self.injury_condition = row[18]
    # アレルギー
    self.allergy_flag = row[19]
    # アレルギー物質
    self.allergy_cause = row[20]
    # 妊婦
    self.pregnancy = row[21]
    # 乳幼児
    self.baby = row[22]
    # 要介護度
    self.upper_care_level_three = row[23]
    # 一人暮らし高齢者（65歳以上）
    self.elderly_alone = row[24]
    # 高齢者世帯（夫婦共に65歳以上）
    self.elderly_couple = row[25]
    # 寝たきり高齢者
    self.bedridden_elderly = row[26]
    # 認知症高齢者
    self.elderly_dementia = row[27]
    # 療育手帳所持者
    self.rehabilitation_certificate = row[28]
    # 身体障害者手帳所持者
    self.physical_disability_certificate = row[29]
    # 本籍
    self.domicile = row[30]
    # 筆頭者
    self.family_head = row[31]
    # 登録者
    self.created_by = user
    # 更新者
    self.updated_by = user
    
    return self
  end
end
