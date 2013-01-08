# -*- coding:utf-8 -*-
class Evacuee < ActiveRecord::Base
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
  before_save :set_attr_for_save
    
  # 住基ステータス
  JUKI_STATUS_COMPLETE   = 1
  JUKI_STATUS_INCOMPLETE = 2
  JUKI_STATUS_NA         = 3
  JUKI_STATUS_CHK_NA     = 4
  
  def set_attr_for_save
    self.juki_status = JUKI_STATUS_INCOMPLETE
    # self.created_by  = current_user
    # self.updated_by  = current_user
  end
end