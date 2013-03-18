# -*- coding:utf-8 -*-
class LocalPerson < ActiveRecord::Base
  
  validates :lgdpf_person_id, :allow_blank => true,
             :numericality => { :only_integer => true }
  validates :person_record_id,
              :length => {:maximum => 500}
  validates :entry_date, :time => true
  validates :expiry_date, :time => true
  validates :author_name,
              :length => {:maximum => 500}
  validates :author_email,
              :length => {:maximum => 500}
  validates :author_phone,
              :length => {:maximum => 500}
  validates :source_name,
              :length => {:maximum => 500}
  validates :source_date, :time => true
  validates :source_url,
              :length => {:maximum => 500}
  validates :full_name,
              :length => {:maximum => 500}
  validates :given_name,
              :length => {:maximum => 500}
  validates :family_name,
              :length => {:maximum => 500}
  validates :alternate_names,
              :length => {:maximum => 500}
  validates :sex,
              :length => {:maximum => 1}
  validates :date_of_birth, :date => true
  validates :age,
              :length => {:maximum => 500}
  validates :home_street,
              :length => {:maximum => 500}
  validates :home_neighborhood,
              :length => {:maximum => 500}
  validates :home_city,
              :length => {:maximum => 500}
  validates :home_state,
              :length => {:maximum => 500}
  validates :home_postal_code,
              :length => {:maximum => 500}
  validates :home_country,
              :length => {:maximum => 500}
  validates :photo_url,
              :length => {:maximum => 500}
  validates :profile_urls,
              :length => {:maximum => 500}
  validates :public_flag, :allow_blank => true,
             :numericality => { :only_integer => true }
  validates :in_city_flag,
              :length => {:maximum => 1}
  validates :shelter_name,
              :length => {:maximum => 20}
  validates :refuge_status,
              :length => {:maximum => 1}
  validates :shelter_entry_date, :date => true
  validates :shelter_leave_date, :date => true
  validates :next_place,
              :length => {:maximum => 100}
  validates :next_place_phone,
              :length => {:maximum => 20}
  validates :injury_flag,
              :length => {:maximum => 1}
  validates :allergy_flag,
              :length => {:maximum => 1}
  validates :pregnancy,
              :length => {:maximum => 1}
  validates :baby,
              :length => {:maximum => 1}
  validates :upper_care_level_three,
              :length => {:maximum => 2}
  validates :elderly_alone,
              :length => {:maximum => 1}
  validates :elderly_couple,
              :length => {:maximum => 1}
  validates :bedridden_elderly,
              :length => {:maximum => 1}
  validates :elderly_dementia,
              :length => {:maximum => 1}
  validates :rehabilitation_certificate,
              :length => {:maximum => 2}
  validates :physical_disability_certificate,
              :length => {:maximum => 1}
  validates :link_flag,
              :inclusion => {:in => [true, false]}
  validates :notes_disabled,
              :inclusion => {:in => [true, false]}
  validates :email_flag,
              :inclusion => {:in => [true, false]}
  validates :status, :allow_blank => true,
             :numericality => { :only_integer => true }
  validates :last_known_location,
              :length => {:maximum => 500}
  validates :family_well,
              :length => {:maximum => 1}
  validates :approved_by,
              :length => {:maximum => 100}
  validates :approved_at, :time => true
  validates :created_by,
              :length => {:maximum => 100}
  validates :updated_by,
              :length => {:maximum => 100}
  validates :deleted_at, :time => true
  
  # 承認状態
  APPROVED_FLAG_ON  = "1" # 済
  APPROVED_FLAG_OFF = "0" # 未済
  
  # 避難者承認処理
  # 引数のID配列を元に避難者情報（LocalPerson）を避難者情報（Evacuee）へ登録する
  # ==== Args
  # _ids_ :: LocalPersonID配列
  # _user_ :: ユーザオブジェクト
  # ==== Return
  # ==== Raise
  def self.exec_approval(ids, user)
    LocalPerson.where(:id => ids).each do |local_person|
      # 承認済みの場合、Evacueeに取り込まない
      next if Evacuee.where(:local_person_id => local_person.id).present?
      # LGDPF上に存在する避難者の場合、Evacueeに取り込まない
      # LGDPMまたはLGDPM-Androidから入力し連携した避難者の場合は重複するため
      next if Evacuee.where(:lgdpf_person_id => local_person.lgdpf_person_id).present?
      evacuee = Evacuee.new
      evacuee = evacuee.exec_insert(local_person)
      evacuee.save!
      local_person.approved_by   = user.login
      local_person.approved_at   = Time.now
      local_person.approved_flag = LocalPerson::APPROVED_FLAG_ON
      local_person.save!
    end
  end
  
  # 避難者編集処理
  # 引数のLGDPF.personオブジェクトを基に各項目を編集する
  # ==== Args
  # _person_ :: LGDPF.personオブジェクト
  # ==== Return
  # LocalPersonオブジェクト
  # ==== Raise
  def exec_insert(person)
    # LGDPFのperson_id
    self.lgdpf_person_id = person.id
    # GooglePersonFinderのperson_id
    self.person_record_id = person.person_record_id
    # レコード作成日時
    self.entry_date = person.entry_date
    # レコード削除予定日時
    self.expiry_date = person.expiry_date
    # レコード作成者名
    self.author_name = person.author_name
    # レコード作成者のメールアドレス
    self.author_email = person.author_email
    # レコード作成者の電話番号
    self.author_phone = person.author_phone
    # 情報元のサイト名
    self.source_name = person.source_name
    # 情報元の投稿日
    self.source_date = person.source_date
    # 情報元のサイトURL
    self.source_url = person.source_url
    # 避難者名前
    self.full_name = person.full_name
    # 避難者_名
    self.given_name = person.given_name
    # 避難者_姓
    self.family_name = person.family_name
    # 避難者_よみがな
    self.alternate_names = person.alternate_names
    # 説明
    self.description = person.description
    # 性別
    self.sex = person.sex
    # 生年月日
    self.date_of_birth = person.date_of_birth
    # 年齢
    self.age = person.age
    # 町名
    self.home_street = person.home_street
    # 近隣
    self.home_neighborhood = person.home_neighborhood
    # 市区町村
    self.home_city = person.home_city
    # 都道府県
    self.home_state = person.home_state
    # 郵便番号
    self.home_postal_code = person.home_postal_code
    # 出身国
    self.home_country = person.home_country
    # 写真のURL
    self.photo_url = person.photo_url
    # プロフィールURL
    self.profile_urls = person.profile_urls
    # 公開フラグ
    self.public_flag = person.public_flag
    # 市内・市外区分
    self.in_city_flag = person.in_city_flag
    # 避難所
    self.shelter_name = person.shelter_name
    # 避難状況
    self.refuge_status = person.refuge_status
    # 避難理由
    self.refuge_reason = person.refuge_reason
    # 入所年月日
    self.shelter_entry_date = person.shelter_entry_date
    # 退所年月日
    self.shelter_leave_date = person.shelter_leave_date
    # 退所先
    self.next_place = person.next_place
    # 退所先電話番号
    self.next_place_phone = person.next_place_phone
    # 負傷
    self.injury_flag = person.injury_flag
    # 負傷内容
    self.injury_condition = person.injury_condition
    # アレルギー
    self.allergy_flag = person.allergy_flag
    # アレルギー物質
    self.allergy_cause = person.allergy_cause
    # 妊婦
    self.pregnancy = person.pregnancy
    # 乳幼児
    self.baby = person.baby
    # 要介護度3以上
    self.upper_care_level_three = person.upper_care_level_three
    # 一人暮らし高齢者（65歳以上）
    self.elderly_alone = person.elderly_alone
    # 高齢者世帯（夫婦共に65歳以上）
    self.elderly_couple = person.elderly_couple
    # 寝たきり高齢者
    self.bedridden_elderly = person.bedridden_elderly
    # 認知症高齢者
    self.elderly_dementia = person.elderly_dementia
    # 療育手帳所持者
    self.rehabilitation_certificate = person.rehabilitation_certificate
    # 身体障害者手帳所持者
    self.physical_disability_certificate = person.physical_disability_certificate
    # 連携フラグ
    self.link_flag = person.link_flag
    # メモ無効フラグ
    self.notes_disabled = person.notes_disabled
    # 新着メッセージ受取フラグ
    self.email_flag = person.email_flag
    # 削除日時
    self.deleted_at = person.deleted_at
    # 家族も無事
    self.family_well = person.family_well
    # 承認状態
    self.approved_flag = APPROVED_FLAG_OFF
    
    return self
  end
end
