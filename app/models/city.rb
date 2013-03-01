# -*- coding:utf-8 -*-
class City < ActiveRecord::Base
  attr_accessible :code, :name
end