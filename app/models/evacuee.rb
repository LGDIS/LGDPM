# -*- coding:utf-8 -*-
class Evacuee < ActiveRecord::Base
  # 論理削除機能の有効化
  acts_as_paranoid
  
  attr_accessible :family_name, :given_name, :alternate_family_name,
    :alternate_given_name, :date_of_birth, :sex, :home_postal_code,
    :in_city_flag, :home_state, :home_city, :home_street, :house_number,
    :shelter_name, :refuge_status, :refuge_reason, :shelter_entry_date,
    :shelter_leave_date, :next_place, :next_place_phone, :injury_flag,
    :injury_condition, :allergy_flag, :allergy_cause, :pregnancy,
    :baby, :upper_care_level_three, :elderly_alone, :elderly_couple,
    :bedridden_elderly, :elderly_dementia, :rehabilitation_certificate,
    :physical_disability_certificate, :juki_status, :note, :created_by,
    :updated_by
    
  # validates :local_person_id
  # validates :lgdpf_person_id
  validates :person_record_id,
              :length => {:maximum => 500}
  validates :family_name, :presence => true,
              :length => {:maximum => 100}
  validates :given_name, :presence => true,
              :length => {:maximum => 100}
  validates :alternate_family_name,
              :length => {:maximum => 100}
  validates :alternate_given_name,
              :length => {:maximum => 100}
  # validates :date_of_birth
  validates :sex,
             :length => {:maximum => 1}
  # validates :age
  validates :home_postal_code,
             :length => {:maximum => 10}
  validates :in_city_flag,
             :length => {:maximum => 1}
  validates :home_state,
              :length => {:maximum => 100}
  validates :home_city,
             :length => {:maximum => 100}
  validates :home_street,
              :length => {:maximum => 100}
  validates :house_number,
              :length => {:maximum => 100}
  validates :shelter_name,
              :length => {:maximum => 20}
  validates :refuge_status,
              :length => {:maximum => 1}
  validates :refuge_reason,
             :length => {:maximum => 4000}
  # validates :shelter_entry_date
  # validates :shelter_leave_date
  validates :next_place,
              :length => {:maximum => 100}
  validates :next_place_phone,
              :length => {:maximum => 20}
  validates :injury_flag,
              :length => {:maximum => 1}
  validates :injury_condition,
              :length => {:maximum => 4000}
  validates :allergy_flag,
              :length => {:maximum => 1}
  validates :allergy_cause,
              :length => {:maximum => 4000}
  validates :pregnancy,
             :length => {:maximum => 1}
  validates :baby,
              :length => {:maximum => 1}
  validates :upper_care_level_three,
              :length => {:maximum => 2}
  validates :elderly_alone,
              :length => {:maximum => 1}
  validates :elderly_couple,
              :length => {:maximum => 1}
  validates :bedridden_elderly,
              :length => {:maximum => 1}
  validates :elderly_dementia,
              :length => {:maximum => 1}
  validates :rehabilitation_certificate,
              :length => {:maximum => 2}
  validates :physical_disability_certificate,
              :length => {:maximum => 1}
  # validates :juki_status
  validates :note,
              :length => {:maximum => 4000}
  validates :linked_by,
              :length => {:maximum => 100}
  # validates :linked_at
  validates :created_by,
              :length => {:maximum => 100}
  validates :updated_by,
              :length => {:maximum => 100}
  
  before_create :set_attr_for_create
    
  # 住基ステータス
  JUKI_STATUS_INCOMPLETE = 1
  JUKI_STATUS_COMPLETE   = 2
  JUKI_STATUS_CHK_NA     = 3
  
  def set_attr_for_create
    # TODO 登録者名・更新者名登録方法検討
    self.juki_status = JUKI_STATUS_INCOMPLETE
    # self.created_by  = current_user
    # self.updated_by  = current_user
  end
  
  # 避難者集計情報取得処理
  # ==== Args
  # ==== Return
  # Evacueeオブジェクト配列
  # ==== Raise
  def self.find_for_count
    select("shelter_name,
            COUNT(*) as head_count,
            COUNT(CASE WHEN injury_flag  IN ('1') THEN 1 ELSE NULL END) AS injury_flag_count,
            COUNT(CASE WHEN allergy_flag IN ('1') THEN 1 ELSE NULL END) AS allergy_flag_count,
            COUNT(CASE WHEN pregnancy IN ('1') THEN 1 ELSE NULL END) AS pregnancy_count,
            COUNT(CASE WHEN baby IN ('1','2') THEN 1 ELSE NULL END) AS baby_count,
            COUNT(CASE WHEN upper_care_level_three IN ('01','02','03','04','05','06','91','92','93') THEN 1 ELSE NULL END) AS upper_care_level_three_count,
            COUNT(CASE WHEN elderly_alone IN ('1') THEN 1 ELSE NULL END) AS elderly_alone_count,
            COUNT(CASE WHEN elderly_couple IN ('1') THEN 1 ELSE NULL END) AS elderly_couple_count,
            COUNT(CASE WHEN bedridden_elderly IN ('1') THEN 1 ELSE NULL END) AS bedridden_elderly_count,
            COUNT(CASE WHEN elderly_dementia IN ('1') THEN 1 ELSE NULL END) AS elderly_dementia_count,
            COUNT(CASE WHEN rehabilitation_certificate IN ('01','02','03','04','05','06','07') THEN 1 ELSE NULL END) AS rehabilitation_certificate_count,
            COUNT(CASE WHEN physical_disability_certificate IN ('1','2') THEN 1 ELSE NULL END) AS physical_disability_certificate_count
    ").group("shelter_name")
  end
  
  # 避難者編集処理
  # 引数のLocalPersonオブジェクトを基に各項目を編集する
  # ==== Args
  # _local_person_ :: LocalPersonオブジェクト
  # ==== Return
  # Evacueeオブジェクト
  # ==== Raise
  def exec_insert(local_person)
    # TODO よみがなの分割方法について検討する
    self.local_person_id = local_person.id
    self.lgdpf_person_id = local_person.lgdpf_person_id
    self.person_record_id = local_person.person_record_id
    self.family_name = local_person.family_name
    self.given_name = local_person.given_name
    if  local_person.alternate_names =~ /(\S*)(\s*)(.*)/
      self.alternate_family_name = $1
      self.alternate_given_name  = $3
    end
    self.date_of_birth = local_person.date_of_birth
    self.sex = local_person.sex
    self.home_postal_code = local_person.home_postal_code
    self.in_city_flag = local_person.in_city_flag
    self.home_state = local_person.home_state
    self.home_city = local_person.home_city
    self.home_street = local_person.home_street
    self.house_number = local_person.house_number
    self.shelter_name = local_person.shelter_name
    self.refuge_status = local_person.refuge_status
    self.refuge_reason = local_person.refuge_reason
    self.shelter_entry_date = local_person.shelter_entry_date
    self.shelter_leave_date = local_person.shelter_leave_date
    self.next_place = local_person.next_place
    self.next_place_phone = local_person.next_place_phone
    self.injury_flag = local_person.injury_flag
    self.injury_condition = local_person.injury_condition
    self.allergy_flag = local_person.allergy_flag
    self.allergy_cause = local_person.allergy_cause
    self.pregnancy = local_person.pregnancy
    self.baby = local_person.baby
    self.upper_care_level_three = local_person.upper_care_level_three
    self.elderly_alone = local_person.elderly_alone
    self.elderly_couple = local_person.elderly_couple
    self.bedridden_elderly = local_person.bedridden_elderly
    self.elderly_dementia = local_person.elderly_dementia
    self.rehabilitation_certificate = local_person.rehabilitation_certificate
    self.physical_disability_certificate = local_person.physical_disability_certificate
    self.note = local_person.description
    
    return self
  end
end