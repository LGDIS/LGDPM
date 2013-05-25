# -*- coding:utf-8 -*-
class JukiMatchingJob
  @queue = :juki_matching

  # 住基情報マッチング非同期処理
  # ==== Args
  # _id_ :: JOB番号
  # ==== Return
  # ==== Raise
  def self.before_enqueue(id)
    Resque.redis.setnx(lock_key(id), DateTime.now.to_i)

    # マッチング処理開始
    if JukiStat.get_stat == JukiStat::MATCHING_READY
      JukiStat.set_stat(JukiStat::MATCHING_RUN) # ステータスを処理中にする
      ActiveRecord::Base.transaction do
        evacue =  Evacuee.mode_in() #避難者データ取得
        evacue.each do |e|
          e.exec_matching
          e.save
        end
      end
    end
  ensure
    JukiStat.set_stat(JukiStat::MATCHING_READY)
  end

  # JOBマッチング処理前
  # ==== Args
  # _id_ :: JOB番号
  # ==== Return
  # ==== Raise
  def self.before_perform(id)
    Rails.logger.debug "---- before performe ----"
    Resque.redis.del(lock_key(id))
    true
  end
  
  # JOBマッチング処理後
  # ==== Args
  # _id_ :: JOB番号
  # ==== Return
  # ==== Raise
  def self.after_perform(id)
    Rails.logger.debug "---- after performe ----"
    JukiStat.set_stat(JukiStat::MATCHING_READY) # ステータスを準備中にする
  end

  #lock key作成処理
  # ==== Args
  # _id_ :: JOB番号
  # ==== Return
  # ==== Raise
  def self.lock_key(id)
    'juki_matching_lock:' + name + '_' + id.to_s
  end
end
