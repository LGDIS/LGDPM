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
  
  # 避難者住基マッチング検索処理
  # ==== Args
  # ==== Return
  # ==== Raise
  def self.find_for_match(evacuee)
    where_str = []
    where_val = {}
    # 氏名カナ（姓）
    if evacuee.alternate_family_name.present?
      where_str << "alternate_family_name = :alternate_family_name"
      where_val[:alternate_family_name] = evacuee.alternate_family_name
    end
    # 氏名カナ（名）
    if evacuee.alternate_given_name.present?
      where_str << "alternate_given_name = :alternate_given_name"
      where_val[:alternate_given_name] = evacuee.alternate_given_name
    end
    # 生年月日
    if evacuee.date_of_birth.present?
      where_str << "date_of_birth = :date_of_birth"
      where_val[:date_of_birth] = evacuee.date_of_birth
    end
    
    return self.find(:all,
      :conditions => [where_str.join(" AND "), where_val])
  end
end
