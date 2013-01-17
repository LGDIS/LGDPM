# -*- coding:utf-8 -*-
class LocalPerson < ActiveRecord::Base
  
  # 避難者編集処理
  # 引数のLGDPF.personオブジェクトを基に各項目を編集する
  # ==== Args
  # _person_ :: LGDPF.personオブジェクト
  # ==== Return
  # LocalPersonオブジェクト
  # ==== Raise
  def exec_insert(person)
    self.lgdpf_person_id = person.id
    self.person_record_id = person.person_record_id
    self.entry_date = person.entry_date
    self.expiry_date = person.expiry_date
    self.author_name = person.author_name
    self.author_email = person.author_email
    self.author_phone = person.author_phone
    self.source_name = person.source_name
    self.source_date = person.source_date
    self.source_url = person.source_url
    self.full_name = person.full_name
    self.given_name = person.given_name
    self.family_name = person.family_name
    self.alternate_names = person.alternate_names
    self.description = person.description
    self.sex = person.sex
    self.date_of_birth = person.date_of_birth
    self.age = person.age
    self.house_number = person.house_number
    self.home_street = person.home_street
    self.home_neighborhood = person.home_neighborhood
    self.home_city = person.home_city
    self.home_state = person.home_state
    self.home_postal_code = person.home_postal_code
    self.home_country = person.home_country
    self.photo_url = person.photo_url
    self.public_flag = person.public_flag
    self.in_city_flag = person.in_city_flag
    self.shelter_name = person.shelter_name
    self.refuge_status = person.refuge_status
    self.refuge_reason = person.refuge_reason
    self.shelter_entry_date = person.shelter_entry_date
    self.shelter_leave_date = person.shelter_leave_date
    self.next_place = person.next_place
    self.next_place_phone = person.next_place_phone
    self.injury_flag = person.injury_flag
    self.injury_condition = person.injury_condition
    self.allergy_flag = person.allergy_flag
    self.allergy_cause = person.allergy_cause
    self.pregnancy = person.pregnancy
    self.baby = person.baby
    self.upper_care_level_three = person.upper_care_level_three
    self.elderly_alone = person.elderly_alone
    self.elderly_couple = person.elderly_couple
    self.bedridden_elderly = person.bedridden_elderly
    self.elderly_dementia = person.elderly_dementia
    self.rehabilitation_certificate = person.rehabilitation_certificate
    self.physical_disability_certificate = person.physical_disability_certificate
    self.link_flag = person.link_flag
    self.notes_disabled = person.notes_disabled
    self.secret = person.secret
    
    return self
  end
end
