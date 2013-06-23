# -*- coding:utf-8 -*-
require 'spec_helper'

describe Person do
  
  describe "#find_for_import" do
    subject { Person.find_for_import }
    let(:person) { FactoryGirl.create(:person) }
    before(:each) do
      ActiveResource::HttpMock.respond_to do |mock|
        mock.get "/people.json", {}, nil
        mock.post "/people.json", {}, nil, 201
      end
      Person.should_receive(:find).with(:all).and_return(person)
    end
    it { subject.should == person }
  end
  
  describe "#exec_insert" do
    subject { person.exec_insert(evacuee) }
    let(:person) { FactoryGirl.create(:person) }
    let(:evacuee) { FactoryGirl.create(:evacuee) }
    before(:each) do
      ActiveResource::HttpMock.respond_to do |mock|
        mock.post "/people.json", {}, nil, 201
        mock.get "/people/1.json", {}, nil
      end
      @time = Time.now
      Time.stub!(:now).and_return(@time)
      
      person.should_receive(:entry_date=).with(@time)
      person.should_receive(:expiry_date=).with(@time.advance(:days => 30))
      person.should_receive(:author_name=).with(I18n.t("messages.person.author_name"))
      person.should_receive(:full_name=).with("#{evacuee.family_name} #{evacuee.given_name}")
      person.should_receive(:given_name=).with(evacuee.given_name)
      person.should_receive(:family_name=).with(evacuee.family_name)
      person.should_receive(:alternate_names=).with("#{evacuee.alternate_family_name} #{evacuee.alternate_given_name}")
      person.should_receive(:description=).with(evacuee.note)
      person.should_receive(:sex=).with(evacuee.sex)
      person.should_receive(:date_of_birth=).with(evacuee.date_of_birth)
      person.should_receive(:age=).with(evacuee.age)
      person.should_receive(:home_street=).with(evacuee.home_street)
      person.should_receive(:home_city=).with(evacuee.home_city)
      person.should_receive(:home_state=).with(evacuee.home_state)
      person.should_receive(:home_postal_code=).with(evacuee.home_postal_code)
      person.should_receive(:in_city_flag=).with(evacuee.in_city_flag)
      person.should_receive(:shelter_name=).with(evacuee.shelter_name)
      person.should_receive(:refuge_status=).with(evacuee.refuge_status)
      person.should_receive(:refuge_reason=).with(evacuee.refuge_reason)
      person.should_receive(:shelter_entry_date=).with(evacuee.shelter_entry_date)
      person.should_receive(:shelter_leave_date=).with(evacuee.shelter_leave_date)
      person.should_receive(:next_place=).with(evacuee.next_place)
      person.should_receive(:next_place_phone=).with(evacuee.next_place_phone)
      person.should_receive(:injury_flag=).with(evacuee.injury_flag)
      person.should_receive(:injury_condition=).with(evacuee.injury_condition)
      person.should_receive(:allergy_flag=).with(evacuee.allergy_flag)
      person.should_receive(:allergy_cause=).with(evacuee.allergy_cause)
      person.should_receive(:pregnancy=).with(evacuee.pregnancy)
      person.should_receive(:baby=).with(evacuee.baby)
      person.should_receive(:upper_care_level_three=).with(evacuee.upper_care_level_three)
      person.should_receive(:elderly_alone=).with(evacuee.elderly_alone)
      person.should_receive(:elderly_couple=).with(evacuee.elderly_couple)
      person.should_receive(:bedridden_elderly=).with(evacuee.bedridden_elderly)
      person.should_receive(:elderly_dementia=).with(evacuee.elderly_dementia)
      person.should_receive(:rehabilitation_certificate=).with(evacuee.rehabilitation_certificate)
      person.should_receive(:physical_disability_certificate=).with(evacuee.physical_disability_certificate)
    end
    it { subject.should == person }
  end
  
end
