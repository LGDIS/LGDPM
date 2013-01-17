# -*- coding:utf-8 -*-
class Note < ActiveResource::Base
  # ActiveResource各種設定
  settings      = YAML.load_file("#{Rails.root}/config/settings.yml")
  self.site     = settings["ldgpf"][Rails.env]["site"]
  self.user     = settings["ldgpf"][Rails.env]["user"]
  self.password = settings["ldgpf"][Rails.env]["password"]
  self.proxy    = settings["ldgpf"][Rails.env]["proxy"]
  
  # ActiveResource
  # LGDPF Note取得処理
  # ==== Args
  # _local_person_ :: LocalPersonオブジェクト
  # ==== Return
  # LGDPF Noteオブジェクト配列
  # ==== Raise
  def self.find_for_import(local_person)
    find(:all, :params => { person_record_id: local_person.id })
  end
  
  # ActiveResource
  # LGDPF Note編集処理
  # ==== Args
  # _evacuee_ :: Evacueeオブジェクト
  # ==== Return
  # LGDPF Noteオブジェクト
  # ==== Raise
  def exec_insert(evacuee)
    self.person_record_id = evacuee.lgdpf_person_id
    self.entry_date = Time.now
    self.author_name = "LGDPM" # current_user.login
    self.source_date = Time.now
    self.status = 4
    self.last_known_location = Rails.cache.read("shelter")["#{evacuee.shelter_name}"]
    if evacuee.juki_status == 1
      self.text = "宮城県石巻市民として確認されました。"
    else
      self.text = "宮城県石巻市民として確認されていません。"
    end
    
    return self
  end
end
