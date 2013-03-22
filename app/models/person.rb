# -*- coding:utf-8 -*-
class Person < ActiveResource::Base
  # ActiveResource各種設定
  self.site     = SETTINGS["activeresource"]["lgdpf"]["site"]
  self.user     = SETTINGS["activeresource"]["lgdpf"]["user"]
  self.password = SETTINGS["activeresource"]["lgdpf"]["password"]
  self.proxy    = SETTINGS["activeresource"]["lgdpf"]["proxy"]
  
  # 公開フラグ
  PUBLIC_FLAG_ON  = 1 # 公開
  PUBLIC_FLAG_OFF = 0 # 非公開
  
  # ActiveResource
  # LGDPF Person取得処理
  # ==== Args
  # ==== Return
  # LGDPF Personオブジェクト配列
  # ==== Raise
  def self.find_for_import
    find(:all)
  end
  
  # ActiveResource
  # LGDPF Person編集処理
  # ==== Args
  # _evacuee_ :: Evacueeオブジェクト
  # ==== Return
  # LGDPF Personオブジェクト
  # ==== Raise
  def exec_insert(evacuee)
    # レコード作成日時
    self.entry_date = Time.now
    # レコード削除予定日時
    self.expiry_date = Time.now.advance(:days => 30)
    # レコード作成者名
    self.author_name = I18n.t("messages.person.author_name")
    # 情報元のサイト名
    # self.source_name
    # 情報元の投稿日
    # self.source_date
    # 情報元のサイトURL
    # self.source_url
    # 避難者名前
    self.full_name = "#{evacuee.family_name} #{evacuee.given_name}"
    # 避難者_名
    self.given_name = evacuee.given_name
    # 避難者_姓
    self.family_name = evacuee.family_name
    # 避難者_よみがな
    self.alternate_names = "#{evacuee.alternate_family_name} #{evacuee.alternate_given_name}"
    # 説明
    self.description = evacuee.note
    # 性別
    self.sex = evacuee.sex
    # 生年月日
    self.date_of_birth = evacuee.date_of_birth
    # 年齢
    self.age = evacuee.age
    # 町名
    self.home_street = evacuee.home_street
    # 市区町村
    self.home_city = evacuee.home_city
    # 都道府県
    @state = State.hash_for_table
    self.home_state = @state[evacuee.home_state]
    # 郵便番号
    self.home_postal_code = evacuee.home_postal_code
    # 出身国
    # self.home_country
    # 公開フラグ
    self.public_flag = evacuee.public_flag
    # 市内・市外区分
    self.in_city_flag = evacuee.in_city_flag
    # 避難所
    self.shelter_name = evacuee.shelter_name
    # 避難状況
    self.refuge_status = evacuee.refuge_status
    # 避難理由
    self.refuge_reason = evacuee.refuge_reason
    # 入所年月日
    self.shelter_entry_date = evacuee.shelter_entry_date
    # 退所年月日
    self.shelter_leave_date = evacuee.shelter_leave_date
    # 退所先
    self.next_place = evacuee.next_place
    # 退所先電話番号
    self.next_place_phone = evacuee.next_place_phone
    # 負傷
    self.injury_flag = evacuee.injury_flag
    # 負傷内容
    self.injury_condition = evacuee.injury_condition
    # アレルギー
    self.allergy_flag = evacuee.allergy_flag
    # アレルギー物質
    self.allergy_cause = evacuee.allergy_cause
    # 妊婦
    self.pregnancy = evacuee.pregnancy
    # 乳幼児
    self.baby = evacuee.baby
    # 要介護度３以上
    self.upper_care_level_three = evacuee.upper_care_level_three
    # １人暮らしの高齢者
    self.elderly_alone = evacuee.elderly_alone
    # 高齢者世帯
    self.elderly_couple = evacuee.elderly_couple
    # 寝たきり高齢者
    self.bedridden_elderly = evacuee.bedridden_elderly
    # 認知症高齢者
    self.elderly_dementia = evacuee.elderly_dementia
    # 療育手帳所持者
    self.rehabilitation_certificate = evacuee.rehabilitation_certificate
    # 身体障害者手帳所持者
    self.physical_disability_certificate = evacuee.physical_disability_certificate
    # 連携フラグ
    self.link_flag = true
    
    return self
  end
end
