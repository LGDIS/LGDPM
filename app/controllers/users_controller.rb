# -*- coding:utf-8 -*-
class UsersController < Devise::SessionsController
  # JSON形式のリクエストを許可する
  respond_to :html, :json

  # サインアウト後にアラートが表示されるのを回避するため
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
