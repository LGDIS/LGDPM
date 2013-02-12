# -*- coding:utf-8 -*-
require 'spec_helper'

describe Evacuee do
  
  describe "validation" do
    let(:model) { FactoryGirl.create(:evacuee) }
    
    it_should_behave_like :max_length, :person_record_id
    it_should_behave_like :max_length, :family_name
    it_should_behave_like :max_length, :given_name
    it_should_behave_like :max_length, :alternate_family_name
    it_should_behave_like :max_length, :alternate_given_name
    it_should_behave_like :max_length, :sex
    it_should_behave_like :max_length, :home_postal_code
    it_should_behave_like :max_length, :in_city_flag
    it_should_behave_like :max_length, :home_state
    it_should_behave_like :max_length, :home_city
    it_should_behave_like :max_length, :home_street
    it_should_behave_like :max_length, :house_number
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
    it_should_behave_like :max_length, :note
    it_should_behave_like :max_length, :linked_by
    it_should_behave_like :max_length, :created_by
    it_should_behave_like :max_length, :updated_by
    
    it_should_behave_like :presence, :family_name
    it_should_behave_like :presence, :given_name
    
    it_should_behave_like :date, :date_of_birth
    it_should_behave_like :date, :shelter_entry_date
    it_should_behave_like :date, :shelter_leave_date
  end
  
  describe "#set_attr_for_create" do
    let(:model) { FactoryGirl.create(:evacuee) }
    it { model.juki_status.should == Evacuee::JUKI_STATUS_INCOMPLETE }
  end
  
  describe "#find_for_count" do
    
  end
  
  describe "#exec_insert" do
    subject { model.exec_insert(local_person) }
    let(:model) { FactoryGirl.create(:evacuee) }
    let(:local_person) { FactoryGirl.create(:local_person) }
    
    describe "local_person_id" do
      it { subject; model.local_person_id.should == local_person.id }
    end
    
    describe "lgdpf_person_id" do
      let(:value) { 123 }
      before { local_person.lgdpf_person_id = value }
      it { subject; model.lgdpf_person_id.should == value }
    end
  end
end
