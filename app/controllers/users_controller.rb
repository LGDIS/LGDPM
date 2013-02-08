# -*- coding:utf-8 -*-
class UsersController < Devise::SessionsController
  # JSON形式のリクエストを許可する
  respond_to :html, :json
  
  # ログイン画面
  # ログイン処理
  # ==== Args
  # _user_login_ :: ログイン名
  # _user_password_ :: パスワード
  # ==== Return
  # ==== Raise
  def create
    # 本番用
    # super
    # 開発用
    user = User.find_by_login(params[:user][:login])
    warden.authenticate!(auth_options) if user.blank?
    sign_in(user, :bypass => true)
    respond_with user, :location => after_sign_in_path_for(user)
  end
  
  # サインアウト後にアラートが表示されるのを回避するため
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
