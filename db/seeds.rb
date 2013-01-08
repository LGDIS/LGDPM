# -*- coding:utf-8 -*-
# コンスタントテーブル
# 性別
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'sex', text: '女性',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'sex', text: '男性',  value: '2', _order: '2')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'sex', text: 'その他',  value: '3', _order: '3')
# 市内・市外区分
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'in_city_flag', text: '市内',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'in_city_flag', text: '市外',  value: '2', _order: '2')
# 避難状況
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'refuge_status', text: '避難済',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'refuge_status', text: '未避難',  value: '2', _order: '2')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'refuge_status', text: '避難所を既に退去済',  value: '3', _order: '3')
# 負傷
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'injury_flag', text: '有',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'injury_flag', text: '無',  value: '2', _order: '2')
# アレルギー
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'allergy_flag', text: '有',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'allergy_flag', text: '無',  value: '2', _order: '2')
# 妊婦
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'pregnancy', text: '妊娠中',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'pregnancy', text: '該当しない',  value: '2', _order: '2')
# 乳幼児
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'baby', text: '乳児',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'baby', text: '幼児',  value: '2', _order: '2')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'baby', text: '該当しない',  value: '3', _order: '3')
# 要介護度3以上
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'upper_care_level_three', text: '非該当',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'upper_care_level_three', text: '要支援',  value: '2', _order: '2')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'upper_care_level_three', text: '要介護1',  value: '3', _order: '3')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'upper_care_level_three', text: '要介護2',  value: '4', _order: '4')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'upper_care_level_three', text: '要介護',  value: '5', _order: '5')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'upper_care_level_three', text: '要介護4',  value: '6', _order: '6')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'upper_care_level_three', text: '要介護5',  value: '7', _order: '7')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'upper_care_level_three', text: 'みなし非該当',  value: '8', _order: '8')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'upper_care_level_three', text: 'みなし要支援',  value: '9', _order: '9')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'upper_care_level_three', text: 'みなし要介護',  value: '10', _order: '10')
# 一人暮らし高齢者（65歳以上）
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'elderly_alone', text: '該当する',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'elderly_alone', text: '該当しない',  value: '2', _order: '2')
# 高齢者世帯（夫婦共に65歳以上）
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'elderly_couple', text: '該当する',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'elderly_couple', text: '該当しない',  value: '2', _order: '2')
# 寝たきり高齢者
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'bedridden_elderly', text: '該当する',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'bedridden_elderly', text: '該当しない',  value: '2', _order: '2')
# 認知症高齢者
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'elderly_dementia', text: '該当する',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'elderly_dementia', text: '該当しない',  value: '2', _order: '2')
# 療育手帳所持者
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: '最重度',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: 'OA',  value: '2', _order: '2')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: 'A1',  value: '3', _order: '3')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: '1度',  value: '4', _order: '4')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: '重度',  value: '5', _order: '5')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: 'A',  value: '6', _order: '6')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: 'A2',  value: '7', _order: '7')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: '2度',  value: '8', _order: '8')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: '中度',  value: '9', _order: '9')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: 'B',  value: '10', _order: '10')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: 'B1',  value: '11', _order: '11')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: '3度',  value: '12', _order: '12')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: '軽度',  value: '13', _order: '13')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: 'C',  value: '14', _order: '14')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: 'B2',  value: '15', _order: '15')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: '4度',  value: '16', _order: '16')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'rehabilitation_certificate', text: 'なし',  value: '17', _order: '17')
# 身体障害者手帳所持者
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'physical_disability_certificate', text: '1級',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'physical_disability_certificate', text: '2級',  value: '2', _order: '2')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'physical_disability_certificate', text: '該当しない',  value: '3', _order: '3')
# 住基ステータス
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'juki_status', text: '済',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'juki_status', text: '未済',  value: '2', _order: '2')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'juki_status', text: '該当者なし',  value: '3', _order: '3')
Constant.create(kind1: 'TD', kind2: 'evacuees', kind3: 'juki_status', text: 'チェック済み該当者なし',  value: '4', _order: '4')
# 住基取込履歴ステータス
Constant.create(kind1: 'TD', kind2: 'juki_histories', kind3: 'status', text: '正常終了',  value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'juki_histories', kind3: 'status', text: '異常終了',  value: '2', _order: '2')
# この人の状況
Constant.create(kind1: 'TD', kind2: 'local_people', kind3: 'status', text: '指定なし', value: '1', _order: '1')
Constant.create(kind1: 'TD', kind2: 'local_people', kind3: 'status', text: '情報を探している', value: '2', _order: '2')
Constant.create(kind1: 'TD', kind2: 'local_people', kind3: 'status', text: '私が本人である', value: '3', _order: '3')
Constant.create(kind1: 'TD', kind2: 'local_people', kind3: 'status', text: 'この人が生きているという情報を入手した', value: '4', _order: '4')
Constant.create(kind1: 'TD', kind2: 'local_people', kind3: 'status', text: 'この人を行方不明と判断した理由がある', value: '5', _order: '5')

# 避難者テーブル
Evacuee.create(
  family_name:                     "北海道",
  given_name:                      "太郎",
  alternate_family_name:           "ホッカイドウ",
  alternate_given_name:            "タロウ",
  date_of_birth:                   "",
  sex:                             2,
  home_postal_code:                "066-0012",
  in_city_flag:                    2,
  home_state:                      "北海道",
  home_city:                       "千歳市",
  home_street:                     "美々",
  house_number:                    "",
  shelter_name:                    11,
  refuge_status:                   1,
  refuge_reason:                   "",
  shelter_entry_date:              "2013/01/01",
  shelter_leave_date:              "",
  next_place:                      "",
  next_place_phone:                "",
  injury_flag:                     1,
  injury_condition:                "",
  allergy_flag:                    2,
  allergy_cause:                   "",
  pregnancy:                       2,
  baby:                            3,
  upper_care_level_three:          1,
  elderly_alone:                   2,
  elderly_couple:                  2,
  bedridden_elderly:               2,
  elderly_dementia:                2,
  rehabilitation_certificate:      3,
  physical_disability_certificate: 3,
  juki_status:                     2,
  note:                            "",
  created_by:                      "admin",
  updated_by:                      "admin"
)
Evacuee.create(
  family_name:                     "東京",
  given_name:                      "花子",
  alternate_family_name:           "トウキョウ",
  alternate_given_name:            "ハナコ",
  date_of_birth:                   "1992/11/26",
  sex:                             1,
  home_postal_code:                "151-0052",
  in_city_flag:                    2,
  home_state:                      "東京都",
  home_city:                       "渋谷区",
  home_street:                     "代々木神園町",
  house_number:                    "１－１",
  shelter_name:                    2121,
  refuge_status:                   2,
  refuge_reason:                   "",
  shelter_entry_date:              "2012/12/25",
  shelter_leave_date:              "",
  next_place:                      "",
  next_place_phone:                "",
  injury_flag:                     2,
  injury_condition:                "",
  allergy_flag:                    1,
  allergy_cause:                   "",
  pregnancy:                       1,
  baby:                            3,
  upper_care_level_three:          1,
  elderly_alone:                   1,
  elderly_couple:                  2,
  bedridden_elderly:               1,
  elderly_dementia:                1,
  rehabilitation_certificate:      6,
  physical_disability_certificate: 1,
  juki_status:                     1,
  note:                            "",
  created_by:                      "admin",
  updated_by:                      "admin"
)
Evacuee.create(
  family_name:                     "神奈川",
  given_name:                      "一郎",
  alternate_family_name:           "カナガワ",
  alternate_given_name:            "イチロウ",
  date_of_birth:                   "1985/02/01",
  sex:                             3,
  home_postal_code:                "232-0018",
  in_city_flag:                    2,
  home_state:                      "神奈川県",
  home_city:                       "横浜市南区",
  home_street:                     "花之木町３丁目",
  house_number:                    "４８−１",
  shelter_name:                    5207,
  refuge_status:                   2,
  refuge_reason:                   "",
  shelter_entry_date:              "2012/12/31",
  shelter_leave_date:              "",
  next_place:                      "",
  next_place_phone:                "",
  injury_flag:                     1,
  injury_condition:                "",
  allergy_flag:                    2,
  allergy_cause:                   "",
  pregnancy:                       2,
  baby:                            1,
  upper_care_level_three:          3,
  elderly_alone:                   2,
  elderly_couple:                  1,
  bedridden_elderly:               2,
  elderly_dementia:                1,
  rehabilitation_certificate:      1,
  physical_disability_certificate: 2,
  juki_status:                     3,
  note:                            "",
  created_by:                      "admin",
  updated_by:                      "admin"
)

# 住基テーブル
Juki.create(
  family_name:           "北海道",
  given_name:            "太郎",
  alternate_family_name: "ホッカイドウ",
  alternate_given_name:  "タロウ",
  date_of_birth:         "1980/07/07",
  address:               "北海道千歳市美々"
)
Juki.create(
  family_name:           "北海道",
  given_name:            "太郎",
  alternate_family_name: "ホッカイドウ",
  alternate_given_name:  "タロウ",
  date_of_birth:         "1972/01/15",
  address:               "北海道虻田郡喜茂別町喜茂別１２３"
)
Juki.create(
  family_name:           "北海道",
  given_name:            "太郎",
  alternate_family_name: "ホッカイドウ",
  alternate_given_name:  "タロウ",
  date_of_birth:         "1990/03/31",
  address:               "北海道札幌市東区北１１条東７丁目１−1"
)
Juki.create(
  family_name:           "東京",
  given_name:            "花子",
  alternate_family_name: "トウキョウ",
  alternate_given_name:  "ハナコ",
  date_of_birth:         "1992/11/26",
  address:               "東京都渋谷区代々木神園町１－１"
)

# 住基取込履歴テーブル
i = 1
100.times do
  JukiHistory.create(
    number: ((rand()*100000)).to_i,
    status: ((rand()*1000)%2+1).to_i,
    created_by: "登録者#{i}",
    updated_by: "更新者#{i}"
  )
  i += 1
end

# ユーザテーブル
User.create(:login => "admin")
