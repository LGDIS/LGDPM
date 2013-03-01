# -*- coding:utf-8 -*-
class Area < ActiveRecord::Base
  attr_accessible :area_code, :name, :remarks, :polygon
end