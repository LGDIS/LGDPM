# -*- coding:utf-8 -*-
FactoryGirl.define do
  factory :juki, class: Juki do |juki|
    juki.family_name 'FAMILY NAME'
    juki.given_name 'GIVEN NAME'
  end
end