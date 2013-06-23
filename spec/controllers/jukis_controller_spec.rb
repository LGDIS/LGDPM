# -*- coding:utf-8 -*-
require 'spec_helper'

describe JukisController do
  # Deviseログイン認証
  login_user
  
  describe "#index" do
    subject { get :index }
    it { should be_success }
    it { should render_template("index") }
  end
  
  describe "#import" do
    describe "ファイルが存在しない場合" do
      subject { post :import }
      it { should be_redirect }
      it { should redirect_to(:action => :index) }
      it "エラーメッセージが設定されていること" do
        subject
        flash[:alert].should == I18n.t("activerecord.errors.messages.file_not_exists")
      end
    end
    
    describe "ファイルの形式が誤っている場合" do
      subject { post :import, :document => { :file => f } }
      let(:f) { fixture_file_upload "/test.xls", "text/comma-separated-values" }
      it { should be_redirect }
      it { should redirect_to(:action => :index) }
      it "エラーメッセージが設定されること" do
        subject
        flash[:alert].should == I18n.t("activerecord.errors.messages.invalid_extension")
      end
    end
    
    describe "正常に取り込める場合" do
      subject { post :import, :document => { :file => f } }
      let(:f) { fixture_file_upload "/test.csv", "text/comma-separated-values" }
      before(:each) do
        ResqueSpec.reset!
        require 'kconv'
        @reader = Kconv.toutf8(f.read)
      end
      it { should be_redirect }
      it { should redirect_to(:action => :index) }
      it "エラーメッセージが設定されないこと" do
        subject
        flash[:alert].should be_nil
      end
      it "キューに登録されていること" do
        subject
        JukiImportJob.should have_queue_size_of(1)
      end
    end
  end
  
end
