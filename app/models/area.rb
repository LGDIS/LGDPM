# -*- coding:utf-8 -*-
class Area < ActiveRecord::Base
  attr_accessible :area_code, :name, :remarks, :polygon
  
  # 地区ハッシュ取得処理
  # ==== Args
  # ==== Return
  # 地区ハッシュオブジェクト {:area_code=>:name, :area_code=>:name}
  # ==== Raise
  def self.hash_for_table
    areas_list = {}
    areas = Area.order(:area_code)
    areas.each do |area|
      areas_list[area.area_code] = {} unless areas_list[area.area_code]
      areas_list[area.area_code] = area.name
    end
    return areas_list
  end
end