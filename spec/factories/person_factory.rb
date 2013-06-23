# -*- coding:utf-8 -*-
FactoryGirl.define do
  factory :person, class: Person do |person|
    person.family_name 'FAMILY NAME'
    person.given_name 'GIVEN NAME'
  end
end