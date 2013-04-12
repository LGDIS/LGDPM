# -*- coding:utf-8 -*-
class JukiMatchingJob
  @queue = :juki_matching
  
  # 住基情報マッチング非同期処理
  # ==== Args
  # ==== Return
  # ==== Raise
  def self.perform(id)
    puts "perform start"
    @jk = JukiStat.first
    
    # マッチング処理開始 
    ActiveRecord::Base.transaction do
      #避難者報取得
      evacue =  Evacuee.scoped #全データ取得
      unless evacue.blank?
        evacue.each do |e|
          jukis = e.matching([])
          if jukis.present? && jukis.size == 1
             # 住基ステータス
            e.juki_status = Evacuee::JUKI_STATUS_COMPLETE
             # 住基識別番号
            e.juki_number = jukis.first.id_number
             # 世帯番号
            e.household_number = jukis.first.household_number
          else
             # 住基ステータス
            e.juki_status = Evacuee::JUKI_STATUS_CHK_NA
          end
          e.save!
        end
      end 
    end 
  end

  def self.before_enqueue(id)
    Resque.redis.setnx(lock_key(id), DateTime.now.to_i)
  end

  def self.before_perform(id)
    puts "---- before performe ----"
    Resque.redis.del(lock_key(id))
    true
  end
  
  # マッチング処理終了 
  def self.after_perform(id)
    puts "---- after performe ----"
    #Resque.dequeue(JukiMatchingJob)
    @jk.status = false #ボタン非活性
    @jk.save  
    
  end

  def self.lock_key(id)
    'mylock:' + name + '_' + id.to_s
  end
end
