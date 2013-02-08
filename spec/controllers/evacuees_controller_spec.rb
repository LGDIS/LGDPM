# -*- coding:utf-8 -*-
require 'spec_helper'

describe EvacueesController do
  # Deviseログイン認証
  login_user
  
  describe "#index" do
    subject { get :index }
    
    describe "HTMLフォーマットの場合" do
      it { should be_success }
      it { should render_template("index") }
    end
    
    describe "JSONフォーマットの場合" do
      before do
        @evacuee = stub_model(Evacuee)
        Evacuee.should_receive(:find_for_count).and_return(@evacuee)
        request.accept = "application/json"
      end
      it { should be_success }
      it "Json形式のEvacueeを返却すること" do
        subject
        response.body.should == @evacuee.to_json
      end
    end
  end
  
  describe "#search" do
    subject { post :search, :commit_kind => commit_kind }
    
    describe "検索ボタンが押下された場合" do
      let(:commit_kind) { "search" }
      it { should be_success }
      it { should render_template("index") }
    end
    
    describe "新規登録ボタンが押下された場合" do
      let(:commit_kind) { "new" }
      it { should be_redirect }
      it { should redirect_to(evacuees_new_url) }
    end
    
    describe "画面印刷ボタンが押下された場合" do
      let(:commit_kind) { "print" }
      
      describe "避難者情報が存在する場合" do
        before do
          FactoryGirl.create(:evacuee)
        end
        it { should be_success }
        it "PDFが出力されること" do
          subject
          response.header["Content-Type"].should == "application/pdf"
        end
      end
      
      describe "避難者情報が存在しない場合" do
        it { should be_success }
        it "エラーメッセージが設定されること" do
          subject
          flash[:alert].should == I18n.t("activerecord.errors.messages.evacuees_not_exists")
        end
      end
    end
    
    describe "その他の場合" do
      let(:commit_kind) { "hoge" }
      it "例外が発生すること" do
        lambda { subject }.should raise_error(RuntimeError)
      end
    end
  end
  
  describe "#create" do
    subject { post :create, :commit_kind => commit_kind, :evacuee => attr, :id => id }
    let(:attr) { { "hoge" => "foge" } }
    let(:id) { "1" }
    
    describe "保存ボタンが押下された場合" do
      let(:commit_kind) { "save" }
      
      describe "HTMLフォーマットの場合" do
        before(:each) do
          @evacuee = mock_model(Evacuee)
          Evacuee.should_receive(:new).with(attr).and_return(@evacuee)
        end
        describe "クリエイトに成功した場合" do
          before(:each) { @evacuee.should_receive(:save).and_return(true) }
          it { should be_redirect }
        end
        describe "クリエイトに失敗した場合" do
          before(:each) { @evacuee.should_receive(:save).and_return(false) }
          it { should be_success }
        end
      end
      
      describe "JSONフォーマットの場合" do
        before do
          @evacuee = stub_model(Evacuee)
          Evacuee.should_receive(:new).with(attr).and_return(@evacuee)
          request.accept = "application/json"
        end
        describe "クリエイトに成功した場合" do
          before(:each) { @evacuee.should_receive(:save).and_return(true) }
          it { should be_success }
          it "Json形式のEvacueeを返却すること" do
            subject
            response.body.should == @evacuee.to_json
          end
        end
        describe "クリエイトに失敗した場合" do
          before(:each) { @evacuee.should_receive(:save).and_return(false) }
          it "InternalServerErrorとなること" do
            subject
            response.code.should == Rack::Utils.status_code(:internal_server_error).to_s
          end
          it "Json形式のEvacueeを返却すること" do
            subject
            response.body.should == @evacuee.to_json
          end
        end
      end
    end
    
    describe "削除ボタンが押下された場合" do
      let(:commit_kind) { "delete" }
      before do
        @evacuee = mock_model(Evacuee)
        Evacuee.should_receive(:find).with(id).and_return(@evacuee)
        @evacuee.should_receive(:destroy)
      end
      it { should be_redirect }
    end
    
    describe "住基マッチングボタンが押下された場合" do
      let(:commit_kind) { "match" }
      before(:each) do 
        @juki = mock_model(Juki)
        @evacuee = mock_model(Evacuee)
        Evacuee.should_receive(:find).with(id).and_return(@evacuee)
      end
      describe "住基マッチングに成功した場合" do
        before do
          Juki.should_receive(:find_for_match).and_return([@juki])
        end
        it { should be_redirect }
        it { should redirect_to(:action => :list, :id => @evacuee.id) }
      end
      describe "住基マッチングに失敗した場合" do
        before do
          Juki.should_receive(:find_for_match).and_return([])
          @evacuee.should_receive(:update_attributes).with({:juki_status => Evacuee::JUKI_STATUS_CHK_NA})
        end
        it { should be_success }
        it { should render_template("edit") }
      end
    end
    
    describe "戻るボタンが押下された場合" do
      let(:commit_kind) { "back" }
      it { should be_redirect }
      it { should redirect_to(root_url) }
    end
    
    describe "その他の場合" do
      let(:commit_kind) { "hoge" }
      it "例外が発生すること" do
        lambda { subject }.should raise_error(RuntimeError)
      end
    end
  end
  
  describe "#edit" do
    subject { get :edit, :id => id }
    let(:id) { "1" }
    before(:each) do
      @evacuee = mock_model(Evacuee)
      Evacuee.should_receive(:find).with(id).and_return(@evacuee)
    end
    it { should be_success }
    it "指定したIDのEvacueeを取得すること" do
      subject
      assigns[:evacuee].should == @evacuee
    end
  end
  
  describe "#update" do
    subject { put :update, :commit_kind => "save", :id => id, :evacuee => attr }
    let(:attr) { { "hoge" => "foge" } }
    let(:id) { "1" }
    before(:each) do
      @evacuee = mock_model(Evacuee)
      Evacuee.should_receive(:find).with(id).and_return(@evacuee)
    end
    describe "アップデートに成功した場合" do
      before(:each) { @evacuee.should_receive(:update_attributes).with(attr).and_return(true) }
      it { should be_redirect }
      it { should redirect_to(evacuees_edit_url(@evacuee)) }
    end
    describe "アップデートに失敗した場合" do
      before(:each) { @evacuee.should_receive(:update_attributes).with(attr).and_return(false) }
      it { should be_success }
      it { should render_template("edit") }
    end
  end

  describe "#match" do
    subject { post :match, :commit_kind => commit_kind, :id => id }
    let(:id) { "1" }
    before(:each) do
      @evacuee = mock_model(Evacuee)
      Evacuee.should_receive(:find).with(id).and_return(@evacuee)
    end
    describe "保存ボタンが押下された場合" do
      let(:commit_kind) { "save" }
      before(:each) do
        @evacuee.should_receive(:update_attributes).with({:juki_status => Evacuee::JUKI_STATUS_COMPLETE})
      end
      it { should be_redirect }
      it { should redirect_to(evacuees_edit_url(@evacuee)) }
    end
    describe "突合実施後戻るボタンが押下された場合" do
      let(:commit_kind) { "na" }
      before(:each) do
        @evacuee.should_receive(:update_attributes).with({:juki_status => Evacuee::JUKI_STATUS_CHK_NA})
      end
      it { should be_redirect }
      it { should redirect_to(evacuees_edit_url(@evacuee)) }
    end
    describe "戻るボタンが押下された場合" do
      let(:commit_kind) { "back" }
      it { should be_redirect }
      it { should redirect_to(evacuees_edit_url(@evacuee)) }
    end
    describe "その他の場合" do
      let(:commit_kind) { "hoge" }
      it "例外が発生すること" do
        lambda { subject }.should raise_error(RuntimeError)
      end
    end
  end
end
