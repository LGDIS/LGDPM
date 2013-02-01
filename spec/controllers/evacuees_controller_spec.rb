# -*- coding:utf-8 -*-
require 'spec_helper'

def evacuee(stubs={})
  @evacuee ||= stub_model(Evacuee, stubs)
end
  
describe EvacueesController do
  login_user
  
  describe "#index" do
    before do
      get :index
    end
    it "response success" do
      response.should be_success
    end
    it "render index" do
      response.should render_template("index")
    end
  end
  
  describe "#index.json" do
    before do
      Evacuee.stub!(:find_for_count).and_return(evacuee)
      get :index, :format => :json
    end
    it "response success" do
      response.should be_success
    end
    it "render json" do
      response.body.should == evacuee.to_json
    end
  end
  
  describe "#search" do
    before do
      post :search, :commit_kind => "search"
    end
    it "response success" do
      response.should be_success
    end
  end
  
  describe "#new" do
    before do
      post :search, :commit_kind => "new"
    end
    it "response success" do
      response.should redirect_to(evacuees_new_url)
    end
  end
  
  describe "#print" do
    before do
      post :search, :commit_kind => "print"
    end
    it "response success" do
      response.should be_success
    end
  end
  
  describe "#create" do
    before do
      post :create, :commit_kind => "save"
    end
    it "response success" do
      response.should be_success
    end
  end
  
  describe "#edit" do
    before do
      Evacuee.stub!(:find).and_return(evacuee)
      get :edit, :id => evacuee
    end
    it "response success" do
      response.should be_success
    end
    it "get @evacuee" do
      assigns[:evacuee].should == evacuee
    end
  end
  
  describe "#update" do
    before(:each) { Evacuee.stub!(:find).and_return(evacuee) }
    
    describe "update success" do
      before do
        evacuee.stub!(:update_attributes).and_return(true)
        put :update, :commit_kind => "save", :id => evacuee
      end
      it "redirect_to edit" do
        response.should redirect_to(evacuees_edit_url(evacuee))
      end
    end
    describe "update failure" do
      before do
        Evacuee.stub!(:find).and_return(evacuee)
        evacuee.stub!(:update_attributes).and_return(false)
        put :update, :commit_kind => "save", :id => evacuee
      end
      it "render edit" do
        response.should render_template("edit")
      end
    end
  end
end
