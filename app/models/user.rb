# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable,
  # :lockable, :timeoutable and :omniauthable
  # :recoverable :rememberable
  devise :ldap_authenticatable, :trackable, :omniauthable, :validatable,
    :confirmable, :registerable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :email, :password, :password_confirmation, :remember_me, :confirmed_at
  # attr_accessible :title, :body
  attr_accessible :provider, :uid

  # 認可プロバイダ識別子
  GOOGLE_IDENTIFIER = 'google'
  TWITTER_IDENTIFIER = 'twitter'
  FACEBOOK_IDENTIFIER = 'facebook'
  OPENAM_IDENTIFIER = 'openam'

  # create user authorized by google
  # ==== Args
  # _access_token_ :: openidアクセストークン
  # _signed_in_resource_ :: RESERVED
  # ==== Return
  # Userオブジェクト
  # ==== Raise
  # RuntimeError :: 想定しないプロバイダによる認可のとき
  def self.find_for_open_id(access_token, signed_in_resource=nil)
    raise "illegal authorizer: #{access_token.provider}" unless access_token.provider == 'google'
    loginid = access_token.info.email
    uid = access_token.uid
    return authorized_user(loginid, uid, GOOGLE_IDENTIFIER)
  end

  # create user authorized by twitter/facebook
  # ==== Args
  # _access_token_ :: oauthアクセストークン
  # _signed_in_resource_ :: RESERVED
  # ==== Return
  # Userオブジェクト
  # ==== Raise
  # RuntimeError :: 想定しないプロバイダによる認可のとき
  def self.find_for_oauth(access_token, signed_in_resource=nil)
    case access_token.provider
    when 'twitter'
      return self.authorized_user("@" + access_token.info.nickname, access_token.uid, TWITTER_IDENTIFIER)
    when 'facebook'
      return self.authorized_user(access_token.info.name, access_token.uid, FACEBOOK_IDENTIFIER)
    end
    raise "illegal authorizer: #{access_token.provider}"
  end

  # create user authorized by openam
  # ==== Args
  # _access_token_ :: アクセストークン
  # _signed_in_resource_ :: RESERVED
  # ==== Return
  # Userオブジェクト
  # ==== Raise
  # RuntimeError :: 想定しないプロバイダによる認可のとき
  def self.find_for_saml(access_token, signed_in_resource=nil)
    raise "illegal authorizer: #{access_token.provider}" unless access_token.provider == 'openam'
    loginid = access_token.uid
    uid = loginid
    return authorized_user(loginid, uid, OPENAM_IDENTIFIER)
  end

  private

  # 認可されたユーザを取得する(存在しなければ新規登録もする)
  # ==== Args
  # _loginid_ :: ログインユーザID(String) ※"@user"や"Yamada Kazuo"などのユーザ名
  # _uid_ :: ログインユーザ識別子(String)
  # _provider_ :: 認可プロバイダ名(String)
  # ==== Return
  # Userオブジェクト
  # ==== Raise
  def self.authorized_user(loginid, uid, provider)
    if user = User.where(:provider => provider, :uid => uid).first
      return user
    else
      return User.create!(:provider => provider, :uid => uid, :login => loginid, :email => "#{uid.gsub('@','_')}@#{provider}.local", :password => random_password, :confirmed_at => Time.now)
    end
  end

  # 擬似ランダム文字列を生成
  # ==== Args
  # ==== Return
  # 半角英数字(40文字)からなるランダムな文字列
  # ==== Raise
  def self.random_password
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    password = ''
    40.times { |i| password << chars[rand(chars.size-1)] }
    return password
  end
end
