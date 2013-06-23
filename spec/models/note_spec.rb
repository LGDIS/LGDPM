# -*- coding:utf-8 -*-
require 'spec_helper'

describe Note do
  
  describe "#find_for_import" do
    subject { Note.find_for_import(local_person) }
    let(:local_person) { FactoryGirl.create(:local_person) }
#    it { Note.should_receive(:find) }
  end
  
  describe "#exec_insert" do
    subject { note.exec_insert(evacuee) }
    let(:note) { FactoryGirl.create(:note) }
    let(:evacuee) { FactoryGirl.create(:evacuee) }
    let(:shelter) { {"1" => {"shelter_code"=>"1", "name"=>"石巻小学校"}} }
    before(:each) do
      ActiveResource::HttpMock.respond_to do |mock|
        mock.post "/notes.json", {}, nil, 201
        mock.get "/notes/1.json", {}, nil
      end
      @time = Time.now
      Time.stub!(:now).and_return(@time)
      
      evacuee.stub!(:shelter_name).and_return("1")
      Rails.stub_chain(:cache, :read).with("shelter").and_return(shelter)
      evacuee.stub!(:juki_status).and_return(Evacuee::JUKI_STATUS_COMPLETE)
      
      note.should_receive(:person_record_id=).with(evacuee.lgdpf_person_id)
      note.should_receive(:entry_date=).with(@time)
      note.should_receive(:author_name=).with(I18n.t("messages.note.author_name"))
      note.should_receive(:source_date=).with(@time)
      note.should_receive(:status=).with(4)
      note.should_receive(:last_known_location=).and_return("石巻小学校")
      note.should_receive(:text=).with(I18n.t("messages.note.text"))
    end
    it { subject.should == note }
  end
  
end
