# -*- coding:utf-8 -*-
class Person < ActiveResource::Base
  settings      = YAML.load_file("#{Rails.root}/config/settings.yml")
  self.site     = settings["ldgpf"][Rails.env]["site"]
  self.user     = settings["ldgpf"][Rails.env]["user"]
  self.password = settings["ldgpf"][Rails.env]["password"]
  self.proxy    = settings["ldgpf"][Rails.env]["proxy"]
  
  def self.find_for_import
    find(:all)
  end
end