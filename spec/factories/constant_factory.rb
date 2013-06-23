# -*- coding:utf-8 -*-
FactoryGirl.define do
  factory :constant, class: Constant do |constant|
    constant.kind1  'TD'
    constant.kind2  'evacuees'
    constant.kind3  'sex'
    constant.text   '女性'
    constant.value  '1'
    constant._order 1
  end
end