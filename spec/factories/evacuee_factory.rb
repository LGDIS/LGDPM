# -*- coding:utf-8 -*-
FactoryGirl.define do
  factory :evacuee, class: Evacuee do |evacuee|
    evacuee.family_name 'FAMILY NAME'
    evacuee.given_name 'GIVEN NAME'
  end
end