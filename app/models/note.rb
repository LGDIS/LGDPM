# -*- coding:utf-8 -*-
class Note < ActiveResource::Base
  # ActiveResource各種設定
  self.site     = SETTINGS["activeresource"]["lgdpf"]["site"]
  self.user     = SETTINGS["activeresource"]["lgdpf"]["user"]
  self.password = SETTINGS["activeresource"]["lgdpf"]["password"]
  self.proxy    = SETTINGS["activeresource"]["lgdpf"]["proxy"]
  
  # 状況
  STATUS_UNSPECIFIED        = 1 # 指定なし
  STATUS_INFORMATION_SOUGHT = 2 # 情報を探している
  STATUS_IS_NOTE_AUTHOR     = 3 # 私が本人である
  STATUS_BELIEVED_ALIVE     = 4 # この人が生きているという情報を入手した
  STATUS_BELIEVED_MISSING   = 5 # この人を行方不明と判断した理由がある
  STATUS_BELIEVED_DEAD      = 6 # この人物が死亡したという情報を入手した
  
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
    self.status = STATUS_UNSPECIFIED
    # 最後に見かけた場所
    self.last_known_location = LocalShelter.hash_for_table[evacuee.shelter_name]
    # メッセージ
    if evacuee.juki_status == Evacuee::JUKI_STATUS_COMPLETE
      self.text = I18n.t("messages.note.complete_text")
    else
      self.text = I18n.t("messages.note.incomplete_text")
    end
    # 連携フラグ
    self.link_flag = true
    
    return self
  end
end
