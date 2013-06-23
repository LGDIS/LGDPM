# -*- coding:utf-8 -*-
FactoryGirl.define do
  factory :note, class: Note do |note|
    note.status 1
    note.last_known_location '日本'
  end
end