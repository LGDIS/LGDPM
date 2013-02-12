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
    subject { model.exec_insert(local_person) }
    let(:model) { FactoryGirl.create(:evacuee) }
    let(:local_person) { FactoryGirl.create(:local_person) }
    
    describe "local_person_id" do
      it { subject; model.local_person_id.should == local_person.id }
    end
    describe "lgdpf_person_id" do
      describe do
        let(:value) { 123 }
        before { local_person[:lgdpf_person_id] = value }
        it { subject; model[:lgdpf_person_id].should == value }
      end
      describe do
        let(:value) { nil }
        before { local_person[:lgdpf_person_id] = value }
        it { subject; model[:lgdpf_person_id].should == value }
      end
    end
    it_should_behave_like :check_value, :person_record_id
    it_should_behave_like :check_value, :family_name
    it_should_behave_like :check_value, :given_name
    describe "alternate_family_name" do
      describe do
        let(:value) { "123 " }
        before { local_person[:alternate_names] = value }
        it { subject; model[:alternate_family_name].should == "123" }
      end
      describe do
        let(:value) { "abc efg" }
        before { local_person[:alternate_names] = value }
        it { subject; model[:alternate_family_name].should == "abc" }
      end
      describe do
        let(:value) { nil }
        before { local_person[:alternate_names] = value }
        it { subject; model[:alternate_family_name].should == value }
      end
    end
    describe "alternate_given_name" do
      describe do
        let(:value) { "123 " }
        before { local_person[:alternate_names] = value }
        it { subject; model[:alternate_given_name].should == "" }
      end
      describe do
        let(:value) { "abc efg" }
        before { local_person[:alternate_names] = value }
        it { subject; model[:alternate_given_name].should == "efg" }
      end
      describe do
        let(:value) { nil }
        before { local_person[:alternate_names] = value }
        it { subject; model[:alternate_given_name].should == value }
      end
    end
    describe "date_of_birth" do
      describe do
        let(:value) { nil }
        before { local_person[:date_of_birth] = value }
        it { subject; model[:date_of_birth].should == value }
      end
      describe do
        let(:value) { "2013-01-01" }
        before { local_person[:date_of_birth] = value }
        it { subject; model[:date_of_birth].to_s.should == value }
      end
    end
    it_should_behave_like :check_value, :age
    it_should_behave_like :check_value, :sex
    it_should_behave_like :check_value, :home_postal_code
    it_should_behave_like :check_value, :in_city_flag
    it_should_behave_like :check_value, :home_state
    it_should_behave_like :check_value, :home_city
    it_should_behave_like :check_value, :home_street
    it_should_behave_like :check_value, :house_number
    it_should_behave_like :check_value, :shelter_name
    it_should_behave_like :check_value, :refuge_status
    it_should_behave_like :check_value, :refuge_reason
    describe "shelter_entry_date" do
      describe do
        let(:value) { nil }
        before { local_person[:shelter_entry_date] = value }
        it { subject; model[:shelter_entry_date].should == value }
      end
      describe do
        let(:value) { "2013-01-01" }
        before { local_person[:shelter_entry_date] = value }
        it { subject; model[:shelter_entry_date].to_s.should == value }
      end
    end
    describe "shelter_leave_date" do
      describe do
        let(:value) { nil }
        before { local_person[:shelter_leave_date] = value }
        it { subject; model[:shelter_leave_date].should == value }
      end
      describe do
        let(:value) { "2013-01-01" }
        before { local_person[:shelter_leave_date] = value }
        it { subject; model[:shelter_leave_date].to_s.should == value }
      end
    end
    it_should_behave_like :check_value, :next_place
    it_should_behave_like :check_value, :next_place_phone
    it_should_behave_like :check_value, :injury_flag
    it_should_behave_like :check_value, :injury_condition
    it_should_behave_like :check_value, :allergy_flag
    it_should_behave_like :check_value, :allergy_cause
    it_should_behave_like :check_value, :pregnancy
    it_should_behave_like :check_value, :baby
    it_should_behave_like :check_value, :upper_care_level_three
    it_should_behave_like :check_value, :elderly_alone
    it_should_behave_like :check_value, :elderly_couple
    it_should_behave_like :check_value, :bedridden_elderly
    it_should_behave_like :check_value, :elderly_dementia
    it_should_behave_like :check_value, :rehabilitation_certificate
    it_should_behave_like :check_value, :physical_disability_certificate
    describe "note" do
      describe do
        let(:value) { 123 }
        before { local_person[:description] = value }
        it { subject; model[:note].should == value }
      end
      describe do
        let(:value) { "abc" }
        before { local_person[:description] = value }
        it { subject; model[:note].should == value }
      end
    end
  end
  
end
