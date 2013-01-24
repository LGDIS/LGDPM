# -*- coding:utf-8 -*-
class UsersController < Devise::SessionsController
  respond_to :html, :json
  
  def new
    super
  end
  
  def create
    # self.resource = warden.authenticate!(auth_options)
    # set_flash_message(:notice, :signed_in) if is_navigational_format?
    # sign_in(resource_name, resource)
    # respond_with resource, :location => after_sign_in_path_for(resource)
    user = User.find_by_login(params[:user][:login])
    warden.authenticate!(auth_options) if user.blank?
    sign_in(user, :bypass => true)
    respond_with user, :location => after_sign_in_path_for(user)
  end
  
  # SignOut後にAlertが表示されるのを回避するため
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
  
  # def sign_in(resource_or_scope, *args)
    # options = args.extract_options!
    # scope = Devise::Mapping.find_scope!(resource_or_scope)
    # resource = args.last || resource_or_scope
# 
    # expire_session_data_after_sign_in!
# 
    # if options[:bypass]
      # warden.session_serializer.store(resource, scope)
    # elsif warden.user(scope) == resource && !options.delete(:force)
      # # Do nothing. User already signed in and we are not forcing it.
      # true
    # else
      # warden.set_user(resource, options.merge!(:scope => scope))
    # end
  # end
end
