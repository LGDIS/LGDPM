# -*- coding:utf-8 -*-
class ApplicationController < ActionController::Base
  # 避難所情報取得は認証なし
  before_filter :authenticate_user!, :except => [:shelters, :address, :master]
  before_filter :init, :except => [:autocomplete_city, :autocomplete_street]
  
  layout :layout_by_resource
  
  protect_from_forgery
  
  class ParameterException < StandardError; end
  
  # set per_page globally
  WillPaginate.per_page = 30
  
  # 初期処理
  # ==== Args
  # ==== Return
  # ==== Raise
  def init
    # セレクトボックスの表示に使用するコンスタントテーブルの取得
    @evacuee_const      = Constant.hash_for_table(Evacuee.table_name)
    @juki_history_const = Constant.hash_for_table(JukiHistory.table_name)
    # DBからマスタを取得
    @area    = Area.hash_for_table
    @shelter = LocalShelter.hash_for_table
    @state   = State.hash_for_table
    # 通常/訓練/試験モードごとの通知文(全画面)
    unless CURRENT_IS_NORMAL_MODE
      @run_mode_announce = I18n.t("announce.header.run_mode_#{CURRENT_RUN_MODE}")
    end
  end
  
  # オートコンプリート市区町村取得処理
  # ==== Args
  # _term_ :: ユーザ入力値
  # _state_ :: 都道府県
  # ==== Return
  # 市区町村jsonオブジェクト
  # ==== Raise
  def autocomplete_city
    @city = City.hash_for_table(params["state"], params["term"])
    respond_to do |format|
      format.json { render :json => @city.values.to_json }
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
    @street = Street.hash_for_table(params["state"], params["term"])
    respond_to do |format|
      format.json { render :json => @street.values.to_json }
    end
  end
  
  # 避難所情報取得処理
  # 避難所情報をjson形式で返却する
  # ==== Args
  # ==== Return
  # 避難所jsonオブジェクト
  # ==== Raise
  def shelters
    respond_to do |format|
      format.json { render :json => @shelter.to_json }
    end
  end
  
  # LGDPM-Android用データ取得処理
  # 住所・マスタ情報をjson形式で返却する
  # ==== Args
  # ==== Return
  # 住所・マスタjsonオブジェクト
  # ==== Raise
  def address
    address_list = {}
    states = State.order(:code)
    states.each do |state|
      address_list[state.code] = {} unless address_list[state.code]
      address_list[state.code][""] = state.name
      cities = City.where("code LIKE '#{state.code}%'").order(:code)
      cities.each do |city|
        city_code = city.code.slice(2, 3)
        address_list[state.code][city_code] = {} unless address_list[state.code][city_code]
        address_list[state.code][city_code][""] = city.name
        streets = Street.where("code LIKE '#{city.code}%'").order(:code)
        streets.each do |street|
          street_code = street.code.slice(5,15)
          address_list[state.code][city_code][street_code] = {} unless address_list[state.code][city_code][street_code]
          address_list[state.code][city_code][street_code] = street.name
        end
      end
    end
    respond_to do |format|
      format.json { render :json => address_list.to_json }
    end
  end

  def master
    respond_to do |format|
      format.json { render :json => @evacuee_const.to_json }
    end
  end

  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
  
  protected
  def layout_by_resource
    if devise_controller? && !user_signed_in?
      "users"
    else
      "application"
    end
  end
end
