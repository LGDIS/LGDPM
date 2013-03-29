# -*- coding:utf-8 -*-
class Evacuee < ActiveRecord::Base
  # 論理削除機能の有効化
  acts_as_paranoid
  
  default_scope order(:alternate_family_name, :alternate_given_name)
  
  attr_accessible :lgdpf_person_id, :person_record_id, :family_name, :given_name, :alternate_family_name,
    :alternate_given_name, :date_of_birth, :sex, :age, :home_postal_code, :in_city_flag, :home_state, :home_city,
    :home_street, :house_number, :shelter_name, :refuge_status, :refuge_reason, :shelter_entry_date,
    :shelter_leave_date, :next_place, :next_place_phone, :injury_flag, :injury_condition, :allergy_flag,
    :allergy_cause, :pregnancy, :baby, :upper_care_level_three, :elderly_alone, :elderly_couple,
    :bedridden_elderly, :elderly_dementia, :rehabilitation_certificate, :physical_disability_certificate,
    :juki_status, :note, :family_well, :juki_number, :household_number, :area, :source_name, :pf_export_flag,
    :public_flag, :created_by, :updated_by, :deleted_at
  
  validates :lgdpf_person_id, :allow_blank => true, :numericality => { :only_integer => true }
  validates :person_record_id, :length => {:maximum => 500}
  validates :family_name, :presence => true, :length => {:maximum => 500}
  validates :given_name, :presence => true, :length => {:maximum => 500}
  validates :alternate_family_name, :length => {:maximum => 500}
  validates :alternate_given_name, :length => {:maximum => 500}
  validates :date_of_birth, :date => true
  validates :sex, :length => {:maximum => 1}
  validates :age, :allow_blank => true, :format => { :with => /^\d+(-\d+)?$/ }, :length => {:maximum => 500}
  validates :home_postal_code, :length => {:maximum => 500}
  validates :in_city_flag, :length => {:maximum => 1}
  validates :home_state, :length => {:maximum => 500}
  validates :home_city, :length => {:maximum => 500}
  validates :home_street, :length => {:maximum => 500}
  validates :house_number, :length => {:maximum => 500}
  validates :shelter_name, :length => {:maximum => 20}
  validates :refuge_status, :length => {:maximum => 1}
  validates :shelter_entry_date, :date => true
  validates :shelter_leave_date, :date => true
  validates :next_place, :length => {:maximum => 100}
  validates :next_place_phone, :length => {:maximum => 20}
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
  validates :juki_status, :allow_blank => true, :numericality => { :only_integer => true }
  validates :family_well, :length => {:maximum => 1}
  validates :juki_number, :length => {:maximum => 500}
  validates :household_number, :length => {:maximum => 500}
  validates :area, :length => {:maximum => 255}
  validates :source_name, :length => {:maximum => 1}
  validates :pf_export_flag, :length => {:maximum => 1}
  validates :public_flag, :allow_blank => true, :numericality => { :only_integer => true }
  validates :deleted_at, :time => true
  validates :created_by, :length => {:maximum => 100}
  validates :updated_by, :length => {:maximum => 100}
  
  after_initialize :init
  before_validation :convert_to_kana
  before_create :set_attr_for_create, :exec_matching
  before_save :set_attr_for_save
  
  # 住基ステータス
  JUKI_STATUS_INCOMPLETE = 1 # 未照合
  JUKI_STATUS_COMPLETE   = 2 # 照合済
  JUKI_STATUS_CHK_NA     = 3 # 照合済対象者なし
  # 市内・市外区分
  IN_CITY_FLAG_INSIDE  = "1" # 市内
  IN_CITY_FLAG_OUTSIDE = "0" # 市外
  # 負傷
  INJURY_FLAG_ON  = "1" # 有
  INJURY_FLAG_OFF = "0" # 無
  # アレルギー
  ALLERGY_FLAG_ON  = "1" # アレルギー有
  ALLERGY_FLAG_OFF = "0" # アレルギー無
  # 家族も無事
  FAMILY_WELL_ON  = "1" # 有
  FAMILY_WELL_OFF = "0" # 無
  # 情報ソース
  SOURCE_NAME_PF = "1" # PF
  SOURCE_NAME_PM = "2" # PM
  # PF出力
  PF_EXPORT_FLAG_ON  = "1" # 出力済
  PF_EXPORT_FLAG_OFF = "0" # 未出力
  # 公開フラグ
  PUBLIC_FLAG_ON  = 1 # 公開
  PUBLIC_FLAG_OFF = 0 # 非公開
  
  # 宮城県コード
  STATE_MIYAGI = "04"
  # 石巻市正規表現
  CITY_ISHINOMAKI = /^(石巻)市?$/
  
  # 変換用ひらがな文字列
  HIRAGANA = "ぁ-ん"
  # 変換用カタカナ文字列
  KATAKANA = "ァ-ン"
  
  # 初期化処理
  def init
    self.public_flag = PUBLIC_FLAG_ON
  end
  
  # ひらがな、半角カタカナを全角カタカナに変換する
  def convert_to_kana
    require 'nkf'
    # 氏名カナ（姓）を変換する
    if self.alternate_family_name.present?
      self.alternate_family_name = NKF::nkf( '-WwXm0', self.alternate_family_name.tr(HIRAGANA, KATAKANA) )
    end
    # 氏名カナ（名）を変換する
    if self.alternate_given_name.present?
      self.alternate_given_name = NKF::nkf( '-WwXm0', self.alternate_given_name.tr(HIRAGANA, KATAKANA) )
    end
  end
  
  # Evacuee登録時に項目を設定する
  def set_attr_for_create
    # 住基ステータス
    self.juki_status = JUKI_STATUS_INCOMPLETE
    # 情報ソース
    self.source_name ||= SOURCE_NAME_PM
    # PF出力
    self.pf_export_flag ||= PF_EXPORT_FLAG_OFF
  end
  
  # Evacuee登録・更新時に項目を設定する
  def set_attr_for_save
    # 負傷
    self.injury_flag = (self.injury_condition.present? ? INJURY_FLAG_ON : INJURY_FLAG_OFF)
    # アレルギー
    self.allergy_flag = (self.allergy_cause.present? ? ALLERGY_FLAG_ON : ALLERGY_FLAG_OFF)
    # 市内・市外区分
    if self.home_state.present? && self.home_city.present?
      if self.home_state == STATE_MIYAGI && self.home_city =~ CITY_ISHINOMAKI
        self.in_city_flag = IN_CITY_FLAG_INSIDE
      else
        self.in_city_flag = IN_CITY_FLAG_OUTSIDE
      end
    end
    # 地区
    if self.shelter_name.present?
      self.area = LocalShelter.where(:shelter_code => self.shelter_name).first.try(:area)
    else
      self.area = nil
    end
  end
  
  # 住基データとのマッチング処理を行う
  def exec_matching
    jukis = self.matching([])
    if jukis.present? && jukis.size == 1
      # 住基ステータス
      self.juki_status = JUKI_STATUS_COMPLETE
      # 住基識別番号
      self.juki_number = jukis.first.id_number
      # 世帯番号
      self.household_number = jukis.first.household_number
    else
      # 住基ステータス
      self.juki_status = JUKI_STATUS_CHK_NA
    end
  end
  
  # 避難者集計情報取得処理
  # ==== Args
  # ==== Return
  # Evacueeオブジェクト配列
  # ==== Raise
  def self.find_for_count
    unscoped.select("shelter_name,
            COUNT(*) as head_count,
            COUNT(CASE WHEN injury_flag  IN ('1') THEN 1 ELSE NULL END) AS injury_flag_count,
            COUNT(CASE WHEN allergy_flag IN ('1') THEN 1 ELSE NULL END) AS allergy_flag_count,
            COUNT(CASE WHEN pregnancy IN ('1') THEN 1 ELSE NULL END) AS pregnancy_count,
            COUNT(CASE WHEN baby IN ('1','2') THEN 1 ELSE NULL END) AS baby_count,
            COUNT(CASE WHEN upper_care_level_three IN ('04','05','06') THEN 1 ELSE NULL END) AS upper_care_level_three_count,
            COUNT(CASE WHEN elderly_alone IN ('1') THEN 1 ELSE NULL END) AS elderly_alone_count,
            COUNT(CASE WHEN elderly_couple IN ('1') THEN 1 ELSE NULL END) AS elderly_couple_count,
            COUNT(CASE WHEN bedridden_elderly IN ('1') THEN 1 ELSE NULL END) AS bedridden_elderly_count,
            COUNT(CASE WHEN elderly_dementia IN ('1') THEN 1 ELSE NULL END) AS elderly_dementia_count,
            COUNT(CASE WHEN rehabilitation_certificate IN ('01','02','03','04','05','06','07') THEN 1 ELSE NULL END) AS rehabilitation_certificate_count,
            COUNT(CASE WHEN physical_disability_certificate IN ('1','2') THEN 1 ELSE NULL END) AS physical_disability_certificate_count
    ").group("shelter_name")
  end
  
  # 避難者連携処理
  # 引数のID配列を元に避難者情報をLGDPFへ連携する
  # ==== Args
  # _evacuees_ :: 避難者配列
  # _user_ :: ユーザオブジェクト
  # ==== Return
  # ==== Raise
  def self.exec_pf_export(evacuees, user)
    evacuees = evacuees.where(:pf_export_flag => PF_EXPORT_FLAG_OFF)
    created_by_pf = evacuees.where(:source_name => SOURCE_NAME_PF, :juki_status => JUKI_STATUS_COMPLETE)
    created_by_pm = evacuees.where(:source_name => SOURCE_NAME_PM, :public_flag => PUBLIC_FLAG_ON)
    
    created_by_pf.each do |evacuee|
      # 安否情報登録
      note = Note.new
      note = note.exec_insert(evacuee)
      note.save
      # PF出力フラグの更新
      evacuee.pf_export_flag = PF_EXPORT_FLAG_ON
      evacuee.save
    end
    
    created_by_pm.each do |evacuee|
      # 避難者情報登録
      person = Person.new
      person = person.exec_insert(evacuee)
      person.save
      # PF_IDの更新
      evacuee.lgdpf_person_id = person.id
      # 安否情報登録
      note = Note.new
      note = note.exec_insert(evacuee)
      note.save
      # PF出力フラグの更新
      evacuee.pf_export_flag = PF_EXPORT_FLAG_ON
      evacuee.save
    end
  end
  
  # 避難者編集処理
  # 引数のPersonオブジェクトを元にEvacueeオブジェクトを編集する
  # ==== Args
  # _person_ :: PersonFinderのPersonオブジェクト
  # ==== Return
  # Evacueeオブジェクト
  # ==== Raise
  def exec_insert(person)
    # LGDPFのperson_id
    self.lgdpf_person_id = person.id
    # GooglePersonFinderのperson_id
    self.person_record_id = person.person_record_id
    # 氏名（姓）
    self.family_name = person.family_name
    # 氏名（名）
    self.given_name = person.given_name
    # 氏名カナ
    if person.alternate_names =~ /^(\S*)(?:\s*)(.*)$/
      # 氏名カナ（姓）
      self.alternate_family_name = $1
      # 氏名カナ（名）
      self.alternate_given_name  = $2
    end
    # 生年月日
    self.date_of_birth = person.date_of_birth
    # 性別
    self.sex = person.sex
    # 年齢
    self.age = person.age
    # 郵便番号
    self.home_postal_code = person.home_postal_code
    # 市内・市外区分
    self.in_city_flag = person.in_city_flag
    # 都道府県
    @state = State.hash_for_table
    self.home_state = @state.invert[person.home_state]
    # 市区町村
    self.home_city = person.home_city
    # 町名
    self.home_street = person.home_street
    # 避難所
    self.shelter_name = person.shelter_name
    # 避難状況
    self.refuge_status = person.refuge_status
    # 避難理由
    self.refuge_reason = person.refuge_reason
    # 入所年月日
    self.shelter_entry_date = person.shelter_entry_date
    # 退所年月日
    self.shelter_leave_date = person.shelter_leave_date
    # 退所先
    self.next_place = person.next_place
    # 退所先電話番号
    self.next_place_phone = person.next_place_phone
    # 負傷
    self.injury_flag = person.injury_flag
    # 負傷内容
    self.injury_condition = person.injury_condition
    # アレルギー
    self.allergy_flag = person.allergy_flag
    # アレルギー物質
    self.allergy_cause = person.allergy_cause
    # 妊婦
    self.pregnancy = person.pregnancy
    # 乳幼児
    self.baby = person.baby
    # 要介護度
    self.upper_care_level_three = person.upper_care_level_three
    # 一人暮らし高齢者（65歳以上）
    self.elderly_alone = person.elderly_alone
    # 高齢者世帯（夫婦共に65歳以上）
    self.elderly_couple = person.elderly_couple
    # 寝たきり高齢者
    self.bedridden_elderly = person.bedridden_elderly
    # 認知症高齢者
    self.elderly_dementia = person.elderly_dementia
    # 療育手帳所持者
    self.rehabilitation_certificate = person.rehabilitation_certificate
    # 身体障害者手帳所持者
    self.physical_disability_certificate = person.physical_disability_certificate
    # 備考
    self.note = person.description
    # 家族も無事
    self.family_well = person.family_well
    # 情報ソース
    self.source_name = SOURCE_NAME_PF
    # 公開フラグ
    self.public_flag = person.public_flag
    
    return self
  end
  
  # 住基情報とのマッチングを行う
  # * patternがブランクの場合、規定の条件でマッチングを行い結果を返す
  # * patternがブランクでない場合、ユーザが指定した条件でマッチングを行い結果を返す
  # ==== Args
  # _pattern_ :: 検索対象項目の配列
  # ==== Return
  # ==== Raise
  def matching(pattern)
    pattern.blank? ? automatic_matching : manual_matching(pattern)
  end
  
  private
  # 規定の順序および条件でマッチングを行う
  # ==== Args
  # ==== Return
  # ==== Raise
  def automatic_matching
    # 設定ファイルを元にマッチングを行う
    JUKI_MATCH_CONDITIONS.each do |condition|
      result = manual_matching(condition)
      return result if result.present? && result.size == 1
    end
    return []
  end
  
  # patternで指定した条件でマッチングを行う
  # ==== Args
  # _pattern_ :: 検索対象項目の配列
  # ==== Return
  # ==== Raise
  def manual_matching(pattern)
    Juki.find_for_match(self, pattern)
  end
end