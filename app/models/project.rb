# -*- coding:utf-8 -*-
class Project < ActiveResource::Base
  include ActiveResource::Extend::AuthWithApi
  # ActiveResource各種設定
  self.site     = SETTINGS["activeresource"]["lgdis"]["site"]
  self.user     = SETTINGS["activeresource"]["lgdis"]["user"]
  self.password = SETTINGS["activeresource"]["lgdis"]["password"]
  self.proxy    = SETTINGS["activeresource"]["lgdis"]["proxy"]
  self.api_key  = SETTINGS["activeresource"]["lgdis"]["api_key"]
  self.format   = :xml
end
