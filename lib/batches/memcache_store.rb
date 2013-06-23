# -*- coding:utf-8 -*-
# バッチの実行コマンド
# rails runner Batches::MemcacheStore.execute
# ==== options
# 実行環境の指定 :: -e production
require 'csv'

class Batches::MemcacheStore
  def self.execute
    p " #{Time.now.to_s} ===== START ===== "

    # 地区(大分類)
    store("area")
    # 地区(小分類)
    store("address")
    # 避難所
    store("shelter")
    
    p " #{Time.now.to_s} =====  END  ===== "
  end
  
  def self.store(file)
    r = CSV.open("#{Rails.root}/lib/batches/#{file}.csv", "r", encoding: "utf8")
    header = r.take(1)[0]

    if file == "address"
      state  = Hash.new
      city   = Hash.new
      street = Hash.new
      r.each do |row|
        state.store(row[0][0..1], row[1])
        city.store(row[0][0..4], row[2])
        street.store(row[0][0..7], row[3])
      end
      Rails.cache.write("state", state)
      Rails.cache.write("city", city)
      Rails.cache.write("street", street)
    end

    h = Hash.new
    r.each do |row|
      h.store(row[0], Hash[*header.zip(row).flatten])
    end
    Rails.cache.write(file, h)

  end
end
