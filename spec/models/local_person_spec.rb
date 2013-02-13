# -*- coding:utf-8 -*-
require 'spec_helper'

describe LocalPerson do
  
  describe "validation" do
    let(:model) { FactoryGirl.create(:local_person) }
    
    it_should_behave_like :max_length, :person_record_id
    it_should_behave_like :max_length, :author_name
    it_should_behave_like :max_length, :author_email
    it_should_behave_like :max_length, :author_phone
    it_should_behave_like :max_length, :source_name
    it_should_behave_like :max_length, :source_url
    it_should_behave_like :max_length, :full_name
    it_should_behave_like :max_length, :given_name
    it_should_behave_like :max_length, :family_name
    it_should_behave_like :max_length, :alternate_names
    it_should_behave_like :max_length, :sex
    it_should_behave_like :max_length, :age
    it_should_behave_like :max_length, :home_street
    it_should_behave_like :max_length, :home_neighborhood
    it_should_behave_like :max_length, :home_city
    it_should_behave_like :max_length, :home_state
    it_should_behave_like :max_length, :home_postal_code
    it_should_behave_like :max_length, :home_country
    it_should_behave_like :max_length, :photo_url
    it_should_behave_like :max_length, :profile_urls
    it_should_behave_like :max_length, :in_city_flag
    it_should_behave_like :max_length, :shelter_name
    it_should_behave_like :max_length, :refuge_status
    it_should_behave_like :max_length, :refuge_reason
    it_should_behave_like :max_length, :next_place
    it_should_behave_like :max_length, :next_place_phone
    it_should_behave_like :max_length, :injury_flag
    it_should_behave_like :max_length, :injury_condition
    it_should_behave_like :max_length, :allergy_flag
    it_should_behave_like :max_length, :allergy_cause
    it_should_behave_like :max_length, :pregnancy
    it_should_behave_like :max_length, :baby
    it_should_behave_like :max_length, :upper_care_level_three
    it_should_behave_like :max_length, :elderly_alone
    it_should_behave_like :max_length, :elderly_couple
    it_should_behave_like :max_length, :bedridden_elderly
    it_should_behave_like :max_length, :elderly_dementia
    it_should_behave_like :max_length, :rehabilitation_certificate
    it_should_behave_like :max_length, :physical_disability_certificate
    it_should_behave_like :max_length, :last_known_location
    it_should_behave_like :max_length, :approved_by
    it_should_behave_like :max_length, :created_by
    it_should_behave_like :max_length, :updated_by
    
    it_should_behave_like :date, :date_of_birth
    it_should_behave_like :date, :shelter_entry_date
    it_should_behave_like :date, :shelter_leave_date
    
    it_should_behave_like :integer, :lgdpf_person_id
    it_should_behave_like :integer, :public_flag
    it_should_behave_like :integer, :status
    
    it_should_behave_like :datetime, :entry_date
    it_should_behave_like :datetime, :expiry_date
    it_should_behave_like :datetime, :source_date
    it_should_behave_like :datetime, :approved_at
    it_should_behave_like :datetime, :deleted_at
  end
  
  describe "#exec_insert" do
    subject { model.exec_insert(param) }
    let(:model) { FactoryGirl.create(:local_person) }
    let(:param) { FactoryGirl.create(:person) }
    before(:each) do
      ActiveResource::HttpMock.respond_to do |mock|
        mock.post   "/people.json",   {}, nil, 201
        mock.get    "/people/1.json", {}, nil
        mock.put    "/people/1.json", {}, nil, 204
        mock.delete "/people/1.json", {}, nil, 200
      end
      param.should_receive(:id).and_return(123)
      param.should_receive(:person_record_id).and_return("google.org")
      param.should_receive(:entry_date).and_return("2012-01-02 12:34:56")
      param.should_receive(:expiry_date).and_return("2013-12-23 23:12:56")
      param.should_receive(:author_name).and_return("author_name")
      param.should_receive(:author_email).and_return("author_email")
      param.should_receive(:author_phone).and_return("author_phone")
      param.should_receive(:source_name).and_return("source_name")
      param.should_receive(:source_date).and_return("2013-02-13 11:00:00")
      param.should_receive(:source_url).and_return("source_url")
      param.should_receive(:full_name).and_return("full_name")
      param.should_receive(:given_name).and_return("given_name")
      param.should_receive(:family_name).and_return("family_name")
      param.should_receive(:alternate_names).and_return("alternate_names")
      param.should_receive(:description).and_return("description")
      param.should_receive(:sex).and_return("m")
      param.should_receive(:date_of_birth).and_return("2013-02-12")
      param.should_receive(:age).and_return("24")
      param.should_receive(:home_street).and_return("町名")
      param.should_receive(:home_neighborhood).and_return("近隣")
      param.should_receive(:home_city).and_return("市区町村")
      param.should_receive(:home_state).and_return("都道府県")
      param.should_receive(:home_postal_code).and_return("郵便番号")
      param.should_receive(:home_country).and_return("出身国")
      param.should_receive(:photo_url).and_return("photo_url")
      param.should_receive(:profile_urls).and_return("profile_urls")
      param.should_receive(:public_flag).and_return(1)
      param.should_receive(:in_city_flag).and_return("2")
      param.should_receive(:shelter_name).and_return("0001")
      param.should_receive(:refuge_status).and_return("3")
      param.should_receive(:refuge_reason).and_return("避難理由")
      param.should_receive(:shelter_entry_date).and_return("2013-03-01")
      param.should_receive(:shelter_leave_date).and_return("2013-04-12")
      param.should_receive(:next_place).and_return("退所先")
      param.should_receive(:next_place_phone).and_return("000-111-222")
      param.should_receive(:injury_flag).and_return("1")
      param.should_receive(:injury_condition).and_return("捻挫")
      param.should_receive(:allergy_flag).and_return("0")
      param.should_receive(:allergy_cause).and_return("なし")
      param.should_receive(:pregnancy).and_return("2")
      param.should_receive(:baby).and_return("3")
      param.should_receive(:upper_care_level_three).and_return("05")
      param.should_receive(:elderly_alone).and_return("6")
      param.should_receive(:elderly_couple).and_return("7")
      param.should_receive(:bedridden_elderly).and_return("8")
      param.should_receive(:elderly_dementia).and_return("9")
      param.should_receive(:rehabilitation_certificate).and_return("10")
      param.should_receive(:physical_disability_certificate).and_return("1")
      param.should_receive(:link_flag).and_return(true)
      param.should_receive(:notes_disabled).and_return(false)
      param.should_receive(:email_flag).and_return(true)
      param.should_receive(:deleted_at).and_return("2000-12-31 23:59:59")
    end
    it { subject; model[:lgdpf_person_id].should == 123 }
    it { subject; model[:person_record_id].should == "google.org" }
    it { subject; model[:entry_date].to_s.should == "2012-01-02 12:34:56 +0900" }
    it { subject; model[:expiry_date].to_s.should == "2013-12-23 23:12:56 +0900" }
    it { subject; model[:author_name].should == "author_name" }
    it { subject; model[:author_email].should == "author_email" }
    it { subject; model[:author_phone].should == "author_phone" }
    it { subject; model[:source_name].should == "source_name" }
    it { subject; model[:source_date].to_s.should == "2013-02-13 11:00:00 +0900" }
    it { subject; model[:source_url].should == "source_url" }
    it { subject; model[:full_name].should == "full_name" }
    it { subject; model[:given_name].should == "given_name" }
    it { subject; model[:family_name].should == "family_name" }
    it { subject; model[:alternate_names].should == "alternate_names" }
    it { subject; model[:description].should == "description" }
    it { subject; model[:sex].should == "m" }
    it { subject; model[:date_of_birth].to_s.should == "2013-02-12" }
    it { subject; model[:age].should == "24" }
    it { subject; model[:home_street].should == "町名" }
    it { subject; model[:home_neighborhood].should == "近隣" }
    it { subject; model[:home_city].should == "市区町村" }
    it { subject; model[:home_state].should == "都道府県" }
    it { subject; model[:home_postal_code].should == "郵便番号" }
    it { subject; model[:home_country].should == "出身国" }
    it { subject; model[:photo_url].should == "photo_url" }
    it { subject; model[:profile_urls].should == "profile_urls" }
    it { subject; model[:public_flag].should == 1 }
    it { subject; model[:in_city_flag].should == "2" }
    it { subject; model[:shelter_name].should == "0001" }
    it { subject; model[:refuge_status].should == "3" }
    it { subject; model[:refuge_reason].should == "避難理由" }
    it { subject; model[:shelter_entry_date].to_s.should == "2013-03-01" }
    it { subject; model[:shelter_leave_date].to_s.should == "2013-04-12" }
    it { subject; model[:next_place].should == "退所先" }
    it { subject; model[:next_place_phone].should == "000-111-222" }
    it { subject; model[:injury_flag].should == "1" }
    it { subject; model[:injury_condition].should == "捻挫" }
    it { subject; model[:allergy_flag].should == "0" }
    it { subject; model[:allergy_cause].should == "なし" }
    it { subject; model[:pregnancy].should == "2" }
    it { subject; model[:baby].should == "3" }
    it { subject; model[:upper_care_level_three].should == "05" }
    it { subject; model[:elderly_alone].should == "6" }
    it { subject; model[:elderly_couple].should == "7" }
    it { subject; model[:bedridden_elderly].should == "8" }
    it { subject; model[:elderly_dementia].should == "9" }
    it { subject; model[:rehabilitation_certificate].should == "10" }
    it { subject; model[:physical_disability_certificate].should == "1" }
    it { subject; model[:link_flag].should == true }
    it { subject; model[:notes_disabled].should == false }
    it { subject; model[:email_flag].should == true }
    it { subject; model[:deleted_at].to_s.should == "2000-12-31 23:59:59 +0900" }
  end
  
end
