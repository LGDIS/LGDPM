# -*- coding:utf-8 -*-
class LocalShelter < ActiveRecord::Base
  self.table_name = "shelters"
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

  # 開設状況
  SHELTER_SORT_MIKAISETSU = "1"  # 未開設
  SHELTER_SORT_KAISETSU   = "2"  # 開設
  SHELTER_SORT_HEISA      = "3"  # 閉鎖
  SHELTER_SORT_FUMEI      = "4"  # 不明
  SHELTER_SORT_JOSETSU    = "5"  # 常設
  
  # 避難所ハッシュ取得処理
  # ==== Args
  # ==== Return
  # 避難所ハッシュオブジェクト {:shelter_code=>:name, :shelter_code=>:name}
  # ==== Raise
  def self.hash_for_table
    shelters_list = {}
    shelters = LocalShelter.select([:shelter_code, :name]).where(:shelter_sort => [SHELTER_SORT_KAISETSU, SHELTER_SORT_JOSETSU]).order(:shelter_code)
    shelters.each do |shelter|
      shelters_list[shelter.shelter_code] = {} unless shelters_list[shelter.shelter_code]
      shelters_list[shelter.shelter_code] = shelter.name
    end
    return shelters_list
  end
end