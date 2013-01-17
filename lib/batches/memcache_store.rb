# -*- coding:utf-8 -*-
# バッチの実行コマンド
# rails runner Batches::MemcacheStore.execute
# ==== options
# 実行環境の指定 :: -e production
require 'csv'

class Batches::MemcacheStore
  def self.execute
    p " #{Time.now.to_s} ===== START ===== "
    
    # 地区
    store("area")
    # 避難所
    store("shelter")
    # 都道府県
    store("state")
    
    i = 0
    47.times do
      i += 1
      # 市区町村
      store("city_#{sprintf("%02d", i)}")
      # 町名
      store("street_#{sprintf("%02d", i)}")
    end
    
    p " #{Time.now.to_s} =====  END  ===== "
  end
  
  def self.store(file)
    r = CSV.open("#{Rails.root}/lib/files/#{file}.csv", "r", encoding: "SJIS")
    h = Hash.new
    r.each do |row|
      h.store(row[0], row[1])
    end
    Rails.cache.write(file, h)
  end
end
