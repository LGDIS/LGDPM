# -*- coding:utf-8 -*-
class LocalShelter < ActiveRecord::Base
  set_table_name "shelters"
  attr_accessible :name, :name_kana, :area, :address, :phone, :fax, 
   :e_mail, :person_responsible, :shelter_type, :shelter_type_detail, 
   :shelter_sort, :opened_at, :closed_at, :capacity, :status, :head_count, 
   :head_count_voluntary, :households, :households_voluntary, :checked_at, 
   :shelter_code, :manager_code, :manager_name, :manager_another_name, 
   :reported_at, :building_damage_info, :electric_infra_damage_info, 
   :communication_infra_damage_info, :other_damage_info, :usable_flag, 
   :openable_flag, :injury_count, :upper_care_level_three_count, :elderly_alone_count, 
   :elderly_couple_count, :bedridden_elderly_count, :elderly_dementia_count, 
   :rehabilitation_certificate_count, :physical_disability_certificate_count, 
   :note, :deleted_at, :created_by, :updated_by
end