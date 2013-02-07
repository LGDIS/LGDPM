# -*- coding:utf-8 -*-
require 'spec_helper'

describe ApplicationController do
  # Deviseログイン認証
  login_user
  
  describe "#init" do
    pending
  end
  
  describe "#get_cache" do
    pending
  end
  
  describe "#autocomplete_city" do
    subject { get :autocomplete_city }
    before(:each) do
      request.accept = "application/json"
    end
    it { should be_success }
  end
  
  describe "#autocomplete_street" do
    subject { get :autocomplete_street }
    before(:each) do
      request.accept = "application/json"
    end
    it { should be_success }
  end
end
