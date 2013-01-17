# -*- coding:utf-8 -*-
class Person < ActiveResource::Base
  # ActiveResource各種設定
  settings      = YAML.load_file("#{Rails.root}/config/settings.yml")
  self.site     = settings["ldgpf"][Rails.env]["site"]
  self.user     = settings["ldgpf"][Rails.env]["user"]
  self.password = settings["ldgpf"][Rails.env]["password"]
  self.proxy    = settings["ldgpf"][Rails.env]["proxy"]
  
  # ActiveResource
  # LGDPF Person取得処理
  # ==== Args
  # ==== Return
  # LGDPF Personオブジェクト配列
  # ==== Raise
  def self.find_for_import
    find(:all)
  end
  
  # ActiveResource
  # LGDPF Person編集処理
  # ==== Args
  # _evacuee_ :: Evacueeオブジェクト
  # ==== Return
  # LGDPF Personオブジェクト
  # ==== Raise
  def exec_insert(evacuee)
    self.entry_date = Time.now
    self.expiry_date = Time.now.advance(:days => 30)
    self.author_name = "LGDPM" # current_user.login
    self.full_name = "#{evacuee.family_name} #{evacuee.given_name}"
    self.given_name = evacuee.given_name
    self.family_name = evacuee.family_name
    self.alternate_names = "#{evacuee.alternate_family_name} #{evacuee.alternate_given_name}"
    self.description = evacuee.note
    self.sex = evacuee.sex
    self.date_of_birth = evacuee.date_of_birth
    self.age = evacuee.age
    self.house_number = evacuee.house_number
    self.home_street = evacuee.home_street
    self.home_city = evacuee.home_city
    self.home_state = evacuee.home_state
    self.home_postal_code = evacuee.home_postal_code
    self.in_city_flag = evacuee.in_city_flag
    self.shelter_name = evacuee.shelter_name
    self.refuge_status = evacuee.refuge_status
    self.refuge_reason = evacuee.refuge_reason
    self.shelter_entry_date = evacuee.shelter_entry_date
    self.shelter_leave_date = evacuee.shelter_leave_date
    self.next_place = evacuee.next_place
    self.next_place_phone = evacuee.next_place_phone
    self.injury_flag = evacuee.injury_flag
    self.injury_condition = evacuee.injury_condition
    self.allergy_flag = evacuee.allergy_flag
    self.allergy_cause = evacuee.allergy_cause
    self.pregnancy = evacuee.pregnancy
    self.baby = evacuee.baby
    self.upper_care_level_three = evacuee.upper_care_level_three
    self.elderly_alone = evacuee.elderly_alone
    self.elderly_couple = evacuee.elderly_couple
    self.bedridden_elderly = evacuee.bedridden_elderly
    self.elderly_dementia = evacuee.elderly_dementia
    self.rehabilitation_certificate = evacuee.rehabilitation_certificate
    self.physical_disability_certificate = evacuee.physical_disability_certificate
    
    return self
  end
end
