# -*- coding:utf-8 -*-
require 'spec_helper'

describe LinkagesController do
  # Deviseログイン認証
  login_user
  
  describe "#index" do
    subject { get :index }
    it { should be_success }
    it { should render_template("index") }
  end
  
  describe "#search" do
    subject { post :search, :commit_kind => commit_kind, :link_evacuees => link_evacuees }
    
    describe "検索ボタンを押下した場合" do
      let(:commit_kind) { "search" }
      let(:link_evacuees) { [] }
      it { should be_success }
      it { should render_template("index") }
    end
    
    describe "連携ボタンを押下した場合" do
      let(:commit_kind) { "link" }
      before(:each) do
        @evacuee = mock_model(Evacuee)
        Evacuee.stub!(:find).and_return(@evacuee)
      end
      
      describe "連携対象が存在する場合" do
        let(:link_evacuees) { [1,2,3] }
        before(:each) do
          # Common
          @time = Time.now
          Time.stub!(:now).and_return(@time)
          # Evacuee
          @evacuee.should_receive(:linked_by=).with(controller.current_user.login)
          @evacuee.should_receive(:linked_at=).with(@time)
          @evacuee.should_receive(:save!)
          # Note ActiveResource
          @note = mock_model(Note)
          Note.should_receive(:new).and_return(@note)
          @note.should_receive(:exec_insert).with(@evacuee).and_return(@note)
          @note.should_receive(:save).and_return(true)
        end
        
        describe "LGDPFに未登録の場合" do
          before(:each) do
            # Person ActiveResource
            @person = mock_model(Person)
            Person.should_receive(:new).and_return(@person)
            @person.should_receive(:exec_insert).with(@evacuee).and_return(@person)
            @person.should_receive(:save).and_return(true)
            # Evacuee
            @evacuee.should_receive(:lgdpf_person_id).and_return(nil)
            @evacuee.should_receive(:lgdpf_person_id=).with(@person.id)
          end
          it { should be_success }
          it { should render_template("index") }
        end
        
        describe "LGDPFに登録済みの場合" do
          before(:each) do
            @evacuee.should_receive(:lgdpf_person_id).and_return(1)
          end
          it { should be_success }
          it { should render_template("index") }
        end
      end
      
      describe "連携対象が存在しない場合" do
        let(:link_evacuees) { [] }
        it { should be_success }
        it { should render_template("index") }
      end
    end
    
    describe "その他の場合" do
      let(:commit_kind) { "hoge" }
      let(:link_evacuees) { [] }
      it "例外が発生すること" do
        lambda { subject }.should raise_error(RuntimeError)
      end
    end
    
  end
end
