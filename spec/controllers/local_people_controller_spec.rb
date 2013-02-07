# -*- coding:utf-8 -*-
require 'spec_helper'

describe LocalPeopleController do
  # Deviseログイン認証
  login_user
  
  describe "#index" do
    subject { get :index }
    it { should be_success }
    it { should render_template("index") }
  end
  
  describe "#search" do
    subject { post :search, :commit_kind => commit_kind, :approval_local_people => approval_local_people }
    
    describe "検索ボタンが押下された場合" do
      let(:commit_kind) { "search" }
      let(:approval_local_people) { [] }
      it { should be_success }
      it { should render_template("index") }
    end
    
    describe "取込ボタンが押下された場合" do
      let(:commit_kind) { "import" }
      let(:approval_local_people) { [] }
      before(:each) do
        # Person ActiveResouce
        @person = mock_model(Person)
        Person.should_receive(:find_for_import).and_return([@person])
        @person.should_receive(:update_attributes).with({ :link_flag => true})
        # Note ActiveResouce
        @note = mock_model(Note)
        Note.should_receive(:find_for_import).with(@person).and_return([@note])
        @note.stub!(:status).and_return("hoge")
        @note.stub!(:last_known_location).and_return("foge")
        @note.should_receive(:update_attributes).with({ :link_flag => true})
        # LocalPerson
        @local_person = mock_model(LocalPerson)
        LocalPerson.should_receive(:new).and_return(@local_person)
        @local_person.should_receive(:exec_insert).with(@person).and_return(@local_person)
        @local_person.should_receive(:status=).with(@note.status)
        @local_person.should_receive(:last_known_location=).with(@note.last_known_location)
        @local_person.should_receive(:save!).and_return(true)
      end
      it { should be_success }
      it { should render_template("index") }
    end
    
    describe "承認ボタンが押下された場合" do
      let(:commit_kind) { "approval" }
      before(:each) do
        @local_person = mock_model(LocalPerson)
        LocalPerson.stub!(:find).and_return(@local_person)
      end
      
      describe "承認対象が存在する場合" do
        let(:approval_local_people) { [1,2,3] }
        before(:each) do
          # Common
          @time = Time.now
          Time.stub!(:now).and_return(@time)
          # Evacuee
          @evacuee = mock_model(Evacuee)
          Evacuee.should_receive(:find_by_local_person_id).with(@local_person.id).and_return(nil)
          Evacuee.should_receive(:find_by_lgdpf_person_id).with(@local_person.lgdpf_person_id).and_return(nil)
          Evacuee.should_receive(:new).and_return(@evacuee)
          @evacuee.should_receive(:exec_insert).with(@local_person).and_return(@evacuee)
          @evacuee.should_receive(:save!)
          # LocalPerson
          @local_person.should_receive(:approved_by=).with(controller.current_user.login)
          @local_person.should_receive(:approved_at=).with(@time)
          @local_person.should_receive(:save!)
        end
        it { should be_success }
        it { should render_template("index") }
      end
      
      describe "承認対象が存在しない場合" do
        let(:approval_local_people) { [] }
        it { should be_success }
        it { should render_template("index") }
      end
    end
    
    describe "その他の場合" do
      let(:commit_kind) { "hoge" }
      let(:approval_local_people) { [] }
      it "例外が発生すること" do
        lambda { subject }.should raise_error(RuntimeError)
      end
    end
  end
  
end
