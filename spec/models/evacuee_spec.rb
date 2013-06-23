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
    it_should_behave_like :max_length, :next_place
    it_should_behave_like :max_length, :next_place_phone
    it_should_behave_like :max_length, :injury_flag
    it_should_behave_like :max_length, :allergy_flag
    it_should_behave_like :max_length, :pregnancy
    it_should_behave_like :max_length, :baby
    it_should_behave_like :max_length, :upper_care_level_three
    it_should_behave_like :max_length, :elderly_alone
    it_should_behave_like :max_length, :elderly_couple
    it_should_behave_like :max_length, :bedridden_elderly
    it_should_behave_like :max_length, :elderly_dementia
    it_should_behave_like :max_length, :rehabilitation_certificate
    it_should_behave_like :max_length, :physical_disability_certificate
    it_should_behave_like :max_length, :family_well
    it_should_behave_like :max_length, :juki_number
    it_should_behave_like :max_length, :household_number
    it_should_behave_like :max_length, :created_by
    it_should_behave_like :max_length, :updated_by
    
    it_should_behave_like :presence, :family_name
    it_should_behave_like :presence, :given_name
    
    it_should_behave_like :date, :date_of_birth
    it_should_behave_like :date, :shelter_entry_date
    it_should_behave_like :date, :shelter_leave_date
    
    it_should_behave_like :datetime, :deleted_at
    
    it_should_behave_like :integer, :lgdpf_person_id
    it_should_behave_like :integer, :juki_status
    
    describe "age" do
      describe "文字列の場合" do
        subject { model.save }
        before { model.age = "hoge" }
        it { should be_false }
      end
      describe "数字の場合" do
        subject { model.save }
        before { model.age = "123" }
        it { should be_true }
      end
      describe "ハイフン区切りの場合" do
        subject { model.save }
        before { model.age = "123-456" }
        it { should be_true }
      end
      describe "ハイフンで終わる数字の場合" do
        subject { model.save }
        before { model.age = "123-" }
        it { should be_false }
      end
      describe "ハイフンで始まる数字の場合" do
        subject { model.save }
        before { model.age = "-456" }
        it { should be_false }
      end
      describe "500文字以内の場合" do
        subject { model.save }
        before { model.age = "1"*500 }
        it { should be_true }
      end
      describe "500文字より多い場合" do
        subject { model.save }
        before { model.age = "1"*501 }
        it { should be_false }
      end
    end
  end
  
  describe "#convert_to_kana" do
    subject { model.save }
    let(:model) { FactoryGirl.create(:evacuee) }
    it_should_behave_like :convert_to_kana, :alternate_family_name
    it_should_behave_like :convert_to_kana, :alternate_given_name
  end
  
  describe "#set_attr_for_create" do
    let(:model) { FactoryGirl.create(:evacuee) }
    it { model.source_name.should == Evacuee::SOURCE_NAME_PM }
  end
  
  describe "#set_attr_for_save" do
    subject { model.save }
    let(:model) { FactoryGirl.create(:evacuee) }
    describe "injury_flag" do
      describe do
        before(:each) { model.injury_condition = "hoge" }
        it { subject.should be_true }
        it { subject; model.injury_flag.should == Evacuee::INJURY_FLAG_ON }
      end
      describe do
        before(:each) { model.injury_condition = nil }
        it { subject.should be_true }
        it { subject; model.injury_flag.should == Evacuee::INJURY_FLAG_OFF }
      end
    end
    describe "allergy_flag" do
      describe do
        before(:each) { model.allergy_cause = "hoge" }
        it { subject.should be_true }
        it { subject; model.allergy_flag.should == Evacuee::ALLERGY_FLAG_ON }
      end
      describe do
        before(:each) { model.allergy_cause = nil }
        it { subject.should be_true }
        it { subject; model.allergy_flag.should == Evacuee::ALLERGY_FLAG_OFF }
      end
    end
    describe "in_city_flag" do
      describe do
        before(:each) do
          model.home_state = Evacuee::STATE_MIYAGI
          model.home_city = "石巻市"
        end
        it { subject.should be_true }
        it { subject; model.in_city_flag.should == Evacuee::IN_CITY_FLAG_INSIDE }
      end
      describe do
        before(:each) do
          model.home_state = "01"
          model.home_city = "aaa"
        end
        it { subject.should be_true }
        it { subject; model.in_city_flag.should == Evacuee::IN_CITY_FLAG_OUTSIDE }
      end
      describe do
        before(:each) do
          model.home_state = nil
          model.home_city = nil
        end
        it { subject.should be_true }
        it { subject; model.in_city_flag.should be_nil }
      end
    end
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
        @evacuee.update_attributes(:injury_condition => value)
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
        @evacuee.update_attributes(:allergy_cause => value)
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
      before(:each) do
        @evacuee = FactoryGirl.create(:evacuee)
        @evacuee.update_attributes(:upper_care_level_three => value)
      end
      context "in aggregate" do
        let(:value) { "04" }
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
      context "in aggregate" do
        let(:value) { "03" }
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
