# -*- coding:utf-8 -*-
FactoryGirl.define do
  factory :user, class: User do |user|
    user.login 'user'
  end
end