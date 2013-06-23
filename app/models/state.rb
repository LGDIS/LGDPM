# -*- coding:utf-8 -*-
class State < ActiveRecord::Base
  attr_accessible :code, :name

  # 都道府県ハッシュ取得処理
  # ==== Args
  # ==== Return
  # 都道府県ハッシュオブジェクト {:code=>:name, :code=>:name}
  # ==== Raise
  def self.hash_for_table
    states_list = {}
    states = State.order(:code)
    states.each do |state|
      states_list[state.code] = {} unless states_list[state.code]
      states_list[state.code] = state.name
    end
    return states_list
  end
end