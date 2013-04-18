# -*- coding:utf-8 -*-
class JukiStat < ActiveRecord::Base
  # 住基マッチングステータス
  MATCHING_RUN   = 1  # 実行中
  MATCHING_READY = 0  # 準備中
  
  # バリデーション
  validates :status, :inclusion => [MATCHING_READY, MATCHING_RUN]
  
  # ステータス取得処理
  # ==== Args
  # ==== Return
  def self.get_stat
    JukiStat.uncached do
      juki_stat = JukiStat.order("id").first
      return juki_stat.status
    end
  end
  
  # ステータス設定処理
  # ==== Args
  #　_flag_ :: 0:未実行 1:実行中
  # ==== Return
  def self.set_stat(flag)
    JukiStat.uncached do
      juki_stat = JukiStat.order("id").first
      juki_stat.status = flag
      juki_stat.save!
    end
  end
end
