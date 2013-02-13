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
    
    it_should_behave_like :integer, :age
    it_should_behave_like :integer, :local_person_id
    it_should_behave_like :integer, :lgdpf_person_id
    it_should_behave_like :integer, :juki_status
  end
  
  describe "#set_attr_for_create" do
    let(:model) { FactoryGirl.create(:evacuee) }
    it { model.juki_status.should == Evacuee::JUKI_STATUS_INCOMPLETE }
  end
  
  describe "#find_for_count" do
    subject { Evacuee.find_for_count }
    describe "shelter_name" do
      let(:value) { "1" }
      before(:each) do
        @evacuee = FactoryGirl.create(:evacuee)
        @evacuee.update_attributes(:shelter_name => value)
      end
      it { subject.first.shelter_name.should == "1" }
      it { subject.first.head_count.should == "1" }
      it { subject.first.injury_flag_count.should == "0" }
      it { subject.first.allergy_flag_count.should == "0" }
      it { subject.first.pregnancy_count.should == "0" }
      it { subject.first.baby_count.should == "0" }
      it { subject.first.upper_care_level_three_count.should == "0" }
      it { subject.first.elderly_alone_count.should == "0" }
      it { subject.first.elderly_couple_count.should == "0" }
      it { subject.first.bedridden_elderly_count.should == "0" }
      it { subject.first.elderly_dementia_count.should == "0" }
      it { subject.first.rehabilitation_certificate_count.should == "0" }
      it { subject.first.physical_disability_certificate_count.should == "0" }
    end
    describe "head_count" do
      before(:each) do
        @evacuee = FactoryGirl.create(:evacuee)
      end
      it { subject.first.shelter_name.should == nil }
      it { subject.first.head_count.should == "1" }
      it { subject.first.injury_flag_count.should == "0" }
      it { subject.first.allergy_flag_count.should == "0" }
      it { subject.first.pregnancy_count.should == "0" }
      it { subject.first.baby_count.should == "0" }
      it { subject.first.upper_care_level_three_count.should == "0" }
      it { subject.first.elderly_alone_count.should == "0" }
      it { subject.first.elderly_couple_count.should == "0" }
      it { subject.first.bedridden_elderly_count.should == "0" }
      it { subject.first.elderly_dementia_count.should == "0" }
      it { subject.first.rehabilitation_certificate_count.should == "0" }
      it { subject.first.physical_disability_certificate_count.should == "0" }
    end
    describe "injury_flag_count" do
      let(:value) { "1" }
      before(:each) do
        @evacuee = FactoryGirl.create(:evacuee)
        @evacuee.update_attributes(:injury_flag => value)
      end
      it { subject.first.shelter_name.should == nil }
      it { subject.first.head_count.should == "1" }
      it { subject.first.injury_flag_count.should == "1" }
      it { subject.first.allergy_flag_count.should == "0" }
      it { subject.first.pregnancy_count.should == "0" }
      it { subject.first.baby_count.should == "0" }
      it { subject.first.upper_care_level_three_count.should == "0" }
      it { subject.first.elderly_alone_count.should == "0" }
      it { subject.first.elderly_couple_count.should == "0" }
      it { subject.first.bedridden_elderly_count.should == "0" }
      it { subject.first.elderly_dementia_count.should == "0" }
      it { subject.first.rehabilitation_certificate_count.should == "0" }
      it { subject.first.physical_disability_certificate_count.should == "0" }
    end
    describe "allergy_flag_count" do
      let(:value) { "1" }
      before(:each) do
        @evacuee = FactoryGirl.create(:evacuee)
        @evacuee.update_attributes(:allergy_flag => value)
      end
      it { subject.first.shelter_name.should == nil }
      it { subject.first.head_count.should == "1" }
      it { subject.first.injury_flag_count.should == "0" }
      it { subject.first.allergy_flag_count.should == "1" }
      it { subject.first.pregnancy_count.should == "0" }
      it { subject.first.baby_count.should == "0" }
      it { subject.first.upper_care_level_three_count.should == "0" }
      it { subject.first.elderly_alone_count.should == "0" }
      it { subject.first.elderly_couple_count.should == "0" }
      it { subject.first.bedridden_elderly_count.should == "0" }
      it { subject.first.elderly_dementia_count.should == "0" }
      it { subject.first.rehabilitation_certificate_count.should == "0" }
      it { subject.first.physical_disability_certificate_count.should == "0" }
    end
    describe "pregnancy_count" do
      let(:value) { "1" }
      before(:each) do
        @evacuee = FactoryGirl.create(:evacuee)
        @evacuee.update_attributes(:pregnancy => value)
      end
      it { subject.first.shelter_name.should == nil }
      it { subject.first.head_count.should == "1" }
      it { subject.first.injury_flag_count.should == "0" }
      it { subject.first.allergy_flag_count.should == "0" }
      it { subject.first.pregnancy_count.should == "1" }
      it { subject.first.baby_count.should == "0" }
      it { subject.first.upper_care_level_three_count.should == "0" }
      it { subject.first.elderly_alone_count.should == "0" }
      it { subject.first.elderly_couple_count.should == "0" }
      it { subject.first.bedridden_elderly_count.should == "0" }
      it { subject.first.elderly_dementia_count.should == "0" }
      it { subject.first.rehabilitation_certificate_count.should == "0" }
      it { subject.first.physical_disability_certificate_count.should == "0" }
    end
    describe "baby_count" do
      let(:value) { "1" }
      before(:each) do
        @evacuee = FactoryGirl.create(:evacuee)
        @evacuee.update_attributes(:baby => value)
      end
      it { subject.first.shelter_name.should == nil }
      it { subject.first.head_count.should == "1" }
      it { subject.first.injury_flag_count.should == "0" }
      it { subject.first.allergy_flag_count.should == "0" }
      it { subject.first.pregnancy_count.should == "0" }
      it { subject.first.baby_count.should == "1" }
      it { subject.first.upper_care_level_three_count.should == "0" }
      it { subject.first.elderly_alone_count.should == "0" }
      it { subject.first.elderly_couple_count.should == "0" }
      it { subject.first.bedridden_elderly_count.should == "0" }
      it { subject.first.elderly_dementia_count.should == "0" }
      it { subject.first.rehabilitation_certificate_count.should == "0" }
      it { subject.first.physical_disability_certificate_count.should == "0" }
    end
    describe "upper_care_level_three_count" do
      let(:value) { "01" }
      before(:each) do
        @evacuee = FactoryGirl.create(:evacuee)
        @evacuee.update_attributes(:upper_care_level_three => value)
      end
      it { subject.first.shelter_name.should == nil }
      it { subject.first.head_count.should == "1" }
      it { subject.first.injury_flag_count.should == "0" }
      it { subject.first.allergy_flag_count.should == "0" }
      it { subject.first.pregnancy_count.should == "0" }
      it { subject.first.baby_count.should == "0" }
      it { subject.first.upper_care_level_three_count.should == "1" }
      it { subject.first.elderly_alone_count.should == "0" }
      it { subject.first.elderly_couple_count.should == "0" }
      it { subject.first.bedridden_elderly_count.should == "0" }
      it { subject.first.elderly_dementia_count.should == "0" }
      it { subject.first.rehabilitation_certificate_count.should == "0" }
      it { subject.first.physical_disability_certificate_count.should == "0" }
    end
    describe "elderly_alone_count" do
      let(:value) { "1" }
      before(:each) do
        @evacuee = FactoryGirl.create(:evacuee)
        @evacuee.update_attributes(:elderly_alone => value)
      end
      it { subject.first.shelter_name.should == nil }
      it { subject.first.head_count.should == "1" }
      it { subject.first.injury_flag_count.should == "0" }
      it { subject.first.allergy_flag_count.should == "0" }
      it { subject.first.pregnancy_count.should == "0" }
      it { subject.first.baby_count.should == "0" }
      it { subject.first.upper_care_level_three_count.should == "0" }
      it { subject.first.elderly_alone_count.should == "1" }
      it { subject.first.elderly_couple_count.should == "0" }
      it { subject.first.bedridden_elderly_count.should == "0" }
      it { subject.first.elderly_dementia_count.should == "0" }
      it { subject.first.rehabilitation_certificate_count.should == "0" }
      it { subject.first.physical_disability_certificate_count.should == "0" }
    end
    describe "elderly_couple_count" do
      let(:value) { "1" }
      before(:each) do
        @evacuee = FactoryGirl.create(:evacuee)
        @evacuee.update_attributes(:elderly_couple => value)
      end
      it { subject.first.shelter_name.should == nil }
      it { subject.first.head_count.should == "1" }
      it { subject.first.injury_flag_count.should == "0" }
      it { subject.first.allergy_flag_count.should == "0" }
      it { subject.first.pregnancy_count.should == "0" }
      it { subject.first.baby_count.should == "0" }
      it { subject.first.upper_care_level_three_count.should == "0" }
      it { subject.first.elderly_alone_count.should == "0" }
      it { subject.first.elderly_couple_count.should == "1" }
      it { subject.first.bedridden_elderly_count.should == "0" }
      it { subject.first.elderly_dementia_count.should == "0" }
      it { subject.first.rehabilitation_certificate_count.should == "0" }
      it { subject.first.physical_disability_certificate_count.should == "0" }
    end
    describe "bedridden_elderly_count" do
      let(:value) { "1" }
      before(:each) do
        @evacuee = FactoryGirl.create(:evacuee)
        @evacuee.update_attributes(:bedridden_elderly => value)
      end
      it { subject.first.shelter_name.should == nil }
      it { subject.first.head_count.should == "1" }
      it { subject.first.injury_flag_count.should == "0" }
      it { subject.first.allergy_flag_count.should == "0" }
      it { subject.first.pregnancy_count.should == "0" }
      it { subject.first.baby_count.should == "0" }
      it { subject.first.upper_care_level_three_count.should == "0" }
      it { subject.first.elderly_alone_count.should == "0" }
      it { subject.first.elderly_couple_count.should == "0" }
      it { subject.first.bedridden_elderly_count.should == "1" }
      it { subject.first.elderly_dementia_count.should == "0" }
      it { subject.first.rehabilitation_certificate_count.should == "0" }
      it { subject.first.physical_disability_certificate_count.should == "0" }
    end
    describe "elderly_dementia_count" do
      let(:value) { "1" }
      before(:each) do
        @evacuee = FactoryGirl.create(:evacuee)
        @evacuee.update_attributes(:elderly_dementia => value)
      end
      it { subject.first.shelter_name.should == nil }
      it { subject.first.head_count.should == "1" }
      it { subject.first.injury_flag_count.should == "0" }
      it { subject.first.allergy_flag_count.should == "0" }
      it { subject.first.pregnancy_count.should == "0" }
      it { subject.first.baby_count.should == "0" }
      it { subject.first.upper_care_level_three_count.should == "0" }
      it { subject.first.elderly_alone_count.should == "0" }
      it { subject.first.elderly_couple_count.should == "0" }
      it { subject.first.bedridden_elderly_count.should == "0" }
      it { subject.first.elderly_dementia_count.should == "1" }
      it { subject.first.rehabilitation_certificate_count.should == "0" }
      it { subject.first.physical_disability_certificate_count.should == "0" }
    end
    describe "rehabilitation_certificate_count" do
      let(:value) { "01" }
      before(:each) do
        @evacuee = FactoryGirl.create(:evacuee)
        @evacuee.update_attributes(:rehabilitation_certificate => value)
      end
      it { subject.first.shelter_name.should == nil }
      it { subject.first.head_count.should == "1" }
      it { subject.first.injury_flag_count.should == "0" }
      it { subject.first.allergy_flag_count.should == "0" }
      it { subject.first.pregnancy_count.should == "0" }
      it { subject.first.baby_count.should == "0" }
      it { subject.first.upper_care_level_three_count.should == "0" }
      it { subject.first.elderly_alone_count.should == "0" }
      it { subject.first.elderly_couple_count.should == "0" }
      it { subject.first.bedridden_elderly_count.should == "0" }
      it { subject.first.elderly_dementia_count.should == "0" }
      it { subject.first.rehabilitation_certificate_count.should == "1" }
      it { subject.first.physical_disability_certificate_count.should == "0" }
    end
    describe "physical_disability_certificate_count" do
      let(:value) { "1" }
      before(:each) do
        @evacuee = FactoryGirl.create(:evacuee)
        @evacuee.update_attributes(:physical_disability_certificate => value)
      end
      it { subject.first.shelter_name.should == nil }
      it { subject.first.head_count.should == "1" }
      it { subject.first.injury_flag_count.should == "0" }
      it { subject.first.allergy_flag_count.should == "0" }
      it { subject.first.pregnancy_count.should == "0" }
      it { subject.first.baby_count.should == "0" }
      it { subject.first.upper_care_level_three_count.should == "0" }
      it { subject.first.elderly_alone_count.should == "0" }
      it { subject.first.elderly_couple_count.should == "0" }
      it { subject.first.bedridden_elderly_count.should == "0" }
      it { subject.first.elderly_dementia_count.should == "0" }
      it { subject.first.rehabilitation_certificate_count.should == "0" }
      it { subject.first.physical_disability_certificate_count.should == "1" }
    end
  end
  
  describe "#exec_insert" do
    subject { model.exec_insert(param) }
    let(:model) { FactoryGirl.create(:evacuee) }
    let(:param) { FactoryGirl.create(:local_person) }
    
    it_should_behave_like :check_value_for_string, :person_record_id
    it_should_behave_like :check_value_for_string, :family_name
    it_should_behave_like :check_value_for_string, :given_name
    it_should_behave_like :check_value_for_string, :sex
    it_should_behave_like :check_value_for_string, :home_postal_code
    it_should_behave_like :check_value_for_string, :in_city_flag
    it_should_behave_like :check_value_for_string, :home_state
    it_should_behave_like :check_value_for_string, :home_city
    it_should_behave_like :check_value_for_string, :home_street
    it_should_behave_like :check_value_for_string, :shelter_name
    it_should_behave_like :check_value_for_string, :refuge_status
    it_should_behave_like :check_value_for_string, :refuge_reason
    it_should_behave_like :check_value_for_string, :next_place
    it_should_behave_like :check_value_for_string, :next_place_phone
    it_should_behave_like :check_value_for_string, :injury_flag
    it_should_behave_like :check_value_for_string, :injury_condition
    it_should_behave_like :check_value_for_string, :allergy_flag
    it_should_behave_like :check_value_for_string, :allergy_cause
    it_should_behave_like :check_value_for_string, :pregnancy
    it_should_behave_like :check_value_for_string, :baby
    it_should_behave_like :check_value_for_string, :upper_care_level_three
    it_should_behave_like :check_value_for_string, :elderly_alone
    it_should_behave_like :check_value_for_string, :elderly_couple
    it_should_behave_like :check_value_for_string, :bedridden_elderly
    it_should_behave_like :check_value_for_string, :elderly_dementia
    it_should_behave_like :check_value_for_string, :rehabilitation_certificate
    it_should_behave_like :check_value_for_string, :physical_disability_certificate
    
    it_should_behave_like :check_value_for_integer, :lgdpf_person_id
    it_should_behave_like :check_value_for_integer, :age
    
    it_should_behave_like :check_value_for_date, :date_of_birth
    it_should_behave_like :check_value_for_date, :shelter_entry_date
    it_should_behave_like :check_value_for_date, :shelter_leave_date
    
    describe "local_person_id" do
      it { subject; model.local_person_id.should == param.id }
    end
    
    describe "alternate_family_name" do
      describe do
        let(:value) { "123 " }
        before { param[:alternate_names] = value }
        it { subject; model[:alternate_family_name].should == "123" }
      end
      describe do
        let(:value) { "abc efg" }
        before { param[:alternate_names] = value }
        it { subject; model[:alternate_family_name].should == "abc" }
      end
      describe do
        let(:value) { nil }
        before { param[:alternate_names] = value }
        it { subject; model[:alternate_family_name].should == value }
      end
    end
    
    describe "alternate_given_name" do
      describe do
        let(:value) { "123 " }
        before { param[:alternate_names] = value }
        it { subject; model[:alternate_given_name].should == "" }
      end
      describe do
        let(:value) { "abc efg" }
        before { param[:alternate_names] = value }
        it { subject; model[:alternate_given_name].should == "efg" }
      end
      describe do
        let(:value) { nil }
        before { param[:alternate_names] = value }
        it { subject; model[:alternate_given_name].should == value }
      end
    end
    
    describe "note" do
      describe do
        let(:value) { 123 }
        before { param[:description] = value }
        it { subject; model[:note].should == value }
      end
      describe do
        let(:value) { "abc" }
        before { param[:description] = value }
        it { subject; model[:note].should == value }
      end
    end
    
  end
  
end
