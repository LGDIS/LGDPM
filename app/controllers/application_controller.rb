# -*- coding:utf-8 -*-
class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  before_filter :init
  
  protect_from_forgery
  
  # 初期処理
  # ==== Args
  # ==== Return
  # ==== Raise
  def init
    # セレクトボックスの表示に使用するコンスタントテーブルの取得
    @evacuee_const = get_const(Evacuee.table_name)
    @juki_history_const = get_const(JukiHistory.table_name)
    @local_person_const = get_const(LocalPerson.table_name)
    # memcacheからマスタを取得
    # !!! 暫定
    @area = Rails.cache.read("area")
    @shelter = Rails.cache.read("shelter")
  end
  
  # コンスタントテーブル取得処理
  # ==== Args
  # _table_name_ :: テーブル名
  # ==== Return
  # コンスタントオブジェクト
  # ==== Raise
  def get_const(table_name)
    constant_list = {}
    constant = Constant.find(:all,
    :conditions => ["kind1=? AND kind2=?", 'TD', table_name],
    :order => "kind3 ASC, _order ASC")
    constant.each do |c|
      constant_list[c.kind3] = {} unless constant_list[c.kind3]
      constant_list[c.kind3][c.value] = c.text
    end
    return constant_list
  end
  
  # DeviseLDAP認証で例外が発生した場合の処理
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
end
