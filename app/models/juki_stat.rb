# -*- coding:utf-8 -*-
class JukiStat < ActiveRecord::Base
  attr_accessible :status
    
  # ステータス取得処理
  # ==== Args
  # ==== Return
    
  def self.get_state
    jk = JukiStat.first
    return jk.status
  end
end
