# -*- coding:utf-8 -*-
# コンスタントテーブル
Constant.destroy_all
# 性別
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'sex', text: '男性',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'sex', text: '女性',  value: '2', _order: '2')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'sex', text: 'その他',  value: '3', _order: '3')
# 市内・市外区分
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'in_city_flag', text: '市内',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'in_city_flag', text: '市外',  value: '0', _order: '2')
# 避難状況
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'refuge_status', text: '避難済',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'refuge_status', text: '未避難',  value: '2', _order: '2')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'refuge_status', text: '避難所を既に退去済',  value: '3', _order: '3')
# 負傷
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'injury_flag', text: '有',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'injury_flag', text: '無',  value: '0', _order: '2')
# アレルギー
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'allergy_flag', text: 'アレルギー有',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'allergy_flag', text: 'アレルギー無',  value: '0', _order: '2')
# 妊婦
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'pregnancy', text: '妊娠中',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'pregnancy', text: '該当しない',  value: '0', _order: '2')
# 乳幼児
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'baby', text: '乳児',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'baby', text: '幼児',  value: '2', _order: '2')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'baby', text: '該当しない',  value: '0', _order: '3')
# 要介護度
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'upper_care_level_three', text: '該当しない',  value: '00', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'upper_care_level_three', text: '要支援',  value: '01', _order: '2')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'upper_care_level_three', text: '要介護1',  value: '02', _order: '3')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'upper_care_level_three', text: '要介護2',  value: '03', _order: '4')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'upper_care_level_three', text: '要介護3',  value: '04', _order: '5')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'upper_care_level_three', text: '要介護4',  value: '05', _order: '6')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'upper_care_level_three', text: '要介護5',  value: '06', _order: '7')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'upper_care_level_three', text: 'みなし非該当',  value: '91', _order: '8')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'upper_care_level_three', text: 'みなし要支援',  value: '92', _order: '9')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'upper_care_level_three', text: 'みなし要介護',  value: '93', _order: '10')
# 一人暮らし高齢者（65歳以上）
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'elderly_alone', text: '該当する',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'elderly_alone', text: '該当しない',  value: '0', _order: '2')
# 高齢者世帯（夫婦共に65歳以上）
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'elderly_couple', text: '該当する',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'elderly_couple', text: '該当しない',  value: '0', _order: '2')
# 寝たきり高齢者
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'bedridden_elderly', text: '該当する',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'bedridden_elderly', text: '該当しない',  value: '0', _order: '2')
# 認知症高齢者
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'elderly_dementia', text: '該当する',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'elderly_dementia', text: '該当しない',  value: '0', _order: '2')
# 療育手帳所持者
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: '最重度',  value: '01', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: 'OA',  value: '02', _order: '2')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: 'A1',  value: '03', _order: '3')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: '1度',  value: '04', _order: '4')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: '重度',  value: '05', _order: '5')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: 'A',  value: '06', _order: '6')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: 'A2',  value: '07', _order: '7')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: '2度',  value: '08', _order: '8')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: '中度',  value: '09', _order: '9')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: 'B',  value: '10', _order: '10')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: 'B1',  value: '11', _order: '11')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: '3度',  value: '12', _order: '12')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: '軽度',  value: '13', _order: '13')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: 'C',  value: '14', _order: '14')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: 'B2',  value: '15', _order: '15')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: '4度',  value: '16', _order: '16')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: '所持なし',  value: '99', _order: '17')
# 身体障害者手帳所持者
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'physical_disability_certificate', text: '1級',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'physical_disability_certificate', text: '2級',  value: '2', _order: '2')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'physical_disability_certificate', text: '該当しない',  value: '0', _order: '3')
# 住基ステータス
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'juki_status', text: '未照合',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'juki_status', text: '照合済',  value: '2', _order: '2')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'juki_status', text: '照合済対象者なし',  value: '3', _order: '3')
# 連携状況
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'linked_flag', text: '未済',  value: '0', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'linked_flag', text: '済',  value: '1', _order: '2')
# 情報ソース
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'source_name', text: 'PF',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'source_name', text: 'PM',  value: '2', _order: '2')
# PF出力
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'pf_export_flag', text: '未出力',  value: '0', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'pf_export_flag', text: '出力済',  value: '1', _order: '2')
# 住基取込履歴ステータス
Constant.create(kind1: 'TD', kind2: 'juki_histories', kind3: 'status', text: '正常終了',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'juki_histories', kind3: 'status', text: '異常終了',  value: '2', _order: '2')

# ユーザテーブル
if User.find_by_login("admin").blank?
  # TODO : adminでログインするため一次的に対応（結合時に削除する）
  User.find_by_sql("insert into users (login, email, encrypted_password, created_at, updated_at, confirmed_at) values('admin', 'admin@gmail.example.com', '$2a$10$iYGZzQPGW0Ig1S.bblPsaeeIicuRyXMzs/O.EcaU3vT0KRSF56E7C', now(), now(), now())")
end

# 地区
require 'csv'
Area.delete_all
reader = CSV.open(File.join(Rails.root,"lib", "batches", "area.csv"), "r", encoding: "utf8")
header = reader.take(1)[0]
reader.each do |row|
  Area.create(:area_code => row[0], :name => row[1], :remarks=> nil, :polygon=> nil)
end
# 避難所
LocalShelter.delete_all
reader = CSV.open(File.join(Rails.root,"lib", "batches", "work_shelter.csv"), "r", encoding: "utf8")
header = reader.take(1)[0]
reader.each do |row|
  LocalShelter.create(
    :name         => row[0],
    :area         => row[1],
    :address      => row[2],
    :shelter_type => row[3],
    :shelter_sort => row[4],
    :shelter_code => row[5])
end
# 住所
State.delete_all
City.delete_all
Street.delete_all
reader = CSV.open(File.join(Rails.root,"lib", "batches", "work_address.csv"), "r", encoding: "utf8")
header = reader.take(1)[0]
work_state, work_city, work_street = nil, nil, nil
reader.each do |row|
  # 都道府県
  # if work_state != row[1]
    # work_state = row[1]
    # State.create(:code => row[0][0..1], :name => row[1])
  # end
  # 市区町村
  if work_city != row[2]
    work_city = row[2]
    City.create(:code => row[0][0..4], :name => row[2])
  end
  # 町名
  if work_street != row[3]
    work_street = row[3]
    Street.create(:code => row[0], :name => row[3])
  end
end

hash = {"01"=>"北海道","02"=>"青森県","03"=>"岩手県","04"=>"宮城県","05"=>"秋田県","06"=>"山形県","07"=>"福島県","08"=>"茨城県",
"09"=>"栃木県","10"=>"群馬県","11"=>"埼玉県","12"=>"千葉県","13"=>"東京都","14"=>"神奈川県","15"=>"新潟県","16"=>"富山県",
"17"=>"石川県","18"=>"福井県","19"=>"山梨県","20"=>"長野県","21"=>"岐阜県","22"=>"静岡県","23"=>"愛知県","24"=>"三重県",
"25"=>"滋賀県","26"=>"京都府","27"=>"大阪府","28"=>"兵庫県","29"=>"奈良県","30"=>"和歌山県","31"=>"鳥取県","32"=>"島根県",
"33"=>"岡山県","34"=>"広島県","35"=>"山口県","36"=>"徳島県","37"=>"香川県","38"=>"愛媛県","39"=>"高知県","40"=>"福岡県",
"41"=>"佐賀県","42"=>"長崎県","43"=>"熊本県","44"=>"大分県","45"=>"宮崎県","46"=>"鹿児島県","47"=>"沖縄県"}
hash.each_pair do |key,value|
  State.create(:code => key, :name => value)
end

# 住基マッチングボタンステータス
JukiStat.delete_all
JukiStat.create [
  {:id => 1, :status => false}
]
