# -*- coding:utf-8 -*-
class Note < ActiveResource::Base
  # ActiveResource各種設定
  settings      = YAML.load_file("#{Rails.root}/config/settings.yml")
  self.site     = settings["lgdpf"][Rails.env]["site"]
  self.user     = settings["lgdpf"][Rails.env]["user"]
  self.password = settings["lgdpf"][Rails.env]["password"]
  self.proxy    = settings["lgdpf"][Rails.env]["proxy"]
  
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
    # 避難者情報との外部キー
    self.person_record_id = evacuee.lgdpf_person_id
    # 登録日
    self.entry_date = Time.now
    # 投稿者
    self.author_name = I18n.t("messages.note.author_name")
    # 作成日時
    self.source_date = Time.now
    # 状況
    self.status = 4
    # 最後に見かけた場所
    self.last_known_location = Rails.cache.read("shelter")["#{evacuee.shelter_name}"]["name"] if evacuee.shelter_name.present?
    # if evacuee.juki_status == Evacuee::JUKI_STATUS_COMPLETE
      # メッセージ
      self.text = I18n.t("messages.note.text")
    # end
    
    return self
  end
end
