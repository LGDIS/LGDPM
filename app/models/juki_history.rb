# -*- coding:utf-8 -*-
class JukiHistory < ActiveRecord::Base
  attr_accessible :number, :status, :created_by, :updated_by
  
  # ステータス
  STATUS_NORMAL = 1
  STATUS_ERROR  = 2
end
