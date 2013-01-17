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
    @area    = Rails.cache.read("area")
    @shelter = Rails.cache.read("shelter")
    @state   = Rails.cache.read("state")
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
  
  # オートコンプリート市区町村取得処理
  # ==== Args
  # _term_ :: ユーザ入力値
  # _state_ :: 都道府県
  # ==== Return
  # 市区町村jsonオブジェクト
  # ==== Raise
  def autocomplete_city
    # 都道府県が未選択の場合オートコンプリートを表示しない
    if params["state"].present?
      @city = Rails.cache.read("city_#{params["state"]}")
      @city.delete_if{|key,value| value !~ /#{params["term"]}/}
    end
    
    respond_to do |format|
      format.json { render :json => (@city.present? ? @city.values.to_json : Hash.new) }
    end
  end
  
  # オートコンプリート町名取得処理
  # ==== Args
  # _term_ :: ユーザ入力値
  # _state_ :: 都道府県
  # ==== Return
  # 町名jsonオブジェクト
  # ==== Raise
  def autocomplete_street
    # 都道府県が未選択の場合オートコンプリートを表示しない
    if params["state"].present?
      @street = Rails.cache.read("street_#{params["state"]}")
      @street.delete_if{|key,value| value !~ /#{params["term"]}/}
    end
    
    respond_to do |format|
      format.json { render :json => (@street.present? ? @street.values.to_json : Hash.new) }
    end
  end
  
  # DeviseLDAP認証で例外が発生した場合の処理
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
end
