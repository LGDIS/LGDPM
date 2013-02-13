# -*- coding:utf-8 -*-
require 'spec_helper'

describe ApplicationController do
  # Deviseログイン認証
  login_user
  
  describe "#init" do
    controller { def index; head :no_content; end }
    subject { get :index }
    let(:hash) { { "hoge" => "foge" } }
    before(:each) do
      Constant.should_receive(:hash_for_table).with(Evacuee.table_name).and_return(true)
      Constant.should_receive(:hash_for_table).with(JukiHistory.table_name).and_return(true)
      Constant.should_receive(:hash_for_table).with(LocalPerson.table_name).and_return(true)
      Rails.stub_chain(:cache, :read).with("area").and_return(hash)
      Rails.stub_chain(:cache, :read).with("shelter").and_return(hash)
      Rails.stub_chain(:cache, :read).with("state").and_return(hash)
    end
    it { subject; assigns[:evacuee_const].should_not be_blank }
    it { subject; assigns[:juki_history_const].should_not be_blank }
    it { subject; assigns[:local_person_const].should_not be_blank }
    it { subject; assigns[:area].should_not be_blank }
    it { subject; assigns[:shelter].should_not be_blank }
    it { subject; assigns[:state].should_not be_blank }
  end
  
  describe "#get_cache" do
    subject { ApplicationController.new.get_cache(value) }
    let(:value) { "area" }
    let(:hash) { {"1"=>{"area_code"=>"1", "name"=>"石巻地区", "remarks"=>"", "polygon"=>""}} }
    before { Rails.stub_chain(:cache, :read).with(value).and_return(hash) }
    it { subject.should == {"1"=>"石巻地区"} }
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
  
  describe "rescue_from" do
    controller do
      def index
        raise DeviseLdapAuthenticatable::LdapException
      end
    end
    subject { get :index }
    it { subject; response.code.should == Rack::Utils.status_code(:internal_server_error).to_s }
  end
end
