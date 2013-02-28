# -*- coding:utf-8 -*-
FactoryGirl.define do
  factory :user, class: User do |user|
    user.login 'user'
    user.email 'hoge@foo.co.jp'
    user.password 'hogehogehoge'
    user.confirmed_at Time.now
  end
end