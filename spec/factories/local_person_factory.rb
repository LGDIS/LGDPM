# -*- coding:utf-8 -*-
FactoryGirl.define do
  factory :local_person, class: LocalPerson do |local_person|
    local_person.family_name 'FAMILY NAME'
    local_person.given_name 'GIVEN NAME'
  end
end