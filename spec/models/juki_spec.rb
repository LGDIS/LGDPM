# -*- coding:utf-8 -*-
require 'spec_helper'

describe Juki do
  
  describe "validation" do
    let(:model) { FactoryGirl.create(:juki) }
    
    it_should_behave_like :max_length, :id_number
    it_should_behave_like :max_length, :household_number
    it_should_behave_like :max_length, :residents_type
    it_should_behave_like :max_length, :residents_state
    it_should_behave_like :max_length, :residents_code
    it_should_behave_like :max_length, :family_name
    it_should_behave_like :max_length, :given_name
    it_should_behave_like :max_length, :alternate_family_name
    it_should_behave_like :max_length, :alternate_given_name
    it_should_behave_like :max_length, :sex
    it_should_behave_like :max_length, :age
    it_should_behave_like :max_length, :home_state
    it_should_behave_like :max_length, :home_city
    it_should_behave_like :max_length, :home_street
    it_should_behave_like :max_length, :house_number
    it_should_behave_like :max_length, :home_postal_code
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
    it_should_behave_like :max_length, :domicile
    it_should_behave_like :max_length, :family_head
    it_should_behave_like :max_length, :created_by
    it_should_behave_like :max_length, :updated_by
    
    it_should_behave_like :date, :date_of_birth
  end
  
  describe "#find_for_match" do
    subject { Juki.find_for_match(evacuee, cond) }
    let(:evacuee) { FactoryGirl.create(:evacuee) }
    let(:juki) { FactoryGirl.create(:juki) }
    before(:each) do
      juki.update_attributes(:alternate_family_name => "aaaaa", :alternate_given_name => "bbbbb",
        :date_of_birth => "2012-12-24", :sex => "2", :home_state => "poiuytrewq",
        :home_city => "kjgfds", :home_street => "2ertyu")
    end
    
    it_should_behave_like :find_for_match, :alternate_family_name, :alternate_family_name, "abc"
    it_should_behave_like :find_for_match, :alternate_given_name, :alternate_given_name, "efg"
    it_should_behave_like :find_for_match, :date_of_birth, :date_of_birth, "2013-01-02"
    it_should_behave_like :find_for_match, :sex, :sex, "1"
    it_should_behave_like :find_for_match, :home_state, :home_state, "qwer"
    it_should_behave_like :find_for_match, :home_city, :home_city, "asdf"
    it_should_behave_like :find_for_match, :home_street, :home_street, "zxcv"
  end
  
  describe "#import" do
    require 'kconv'
    subject { Juki.import(reader, user.login) }
    let(:reader) { Kconv.toutf8(file.read) }
    let(:user) { FactoryGirl.create(:user) }
    describe "正常終了の場合" do
      let(:file) { File.open(File.join(Rails.root,"spec","fixtures", "test.csv")) }
      it { lambda{ subject }.should change(JukiHistory, :count).by(1) }
      it { lambda{ subject }.should change(Juki, :count).by(100) }
      it { subject; JukiHistory.first.status.should == JukiHistory::STATUS_NORMAL }
    end
    describe "異常終了の場合" do
      describe do
        let(:file) { File.open(File.join(Rails.root,"spec","fixtures", "test_valid_err.csv")) }
        it { lambda{ subject }.should raise_error(RuntimeError) }
      end
      describe do
        let(:file) { File.open(File.join(Rails.root,"spec","fixtures", "test_layout_err.csv")) }
        it { lambda{ subject }.should raise_error(RuntimeError) }
      end
    end
  end
  
  describe "#exec_insert" do
    subject { model.exec_insert(row, "user") }
    let(:model) { FactoryGirl.create(:juki) }
    let(:row) { [
      "000000000000001", # row[0]
      "000000000000101", # row[1]
      "1", # row[2]
      "1", # row[3]
      "00000000001", # row[4]
      "今居", # row[5]
      "厚", # row[6]
      "イマイ", # row[7]
      "アツシ", # row[8]
      "1", # row[9]
      "36", # row[10]
      "1998/7/14", # row[11]
      "東京都", # row[12]
      "千代田区", # row[13]
      "一ツ橋一丁目", # row[14]
      "ビル１", # row[15]
      "123-4567", # row[16]
      "1", # row[17]
      "負傷内容１", # row[18]
      "1", # row[19]
      "アレルギー物質１", # row[20]
      "1", # row[21]
      "1", # row[22]
      "00", # row[23]
      "0", # row[24]
      "0", # row[25]
      "0", # row[26]
      "0", # row[27]
      "01", # row[28]
      "2", # row[29]
      "東京都千代田区一ツ橋一丁目", # row[30]
      "今居厚", # row[31]
    ] }
    it { subject["id_number"].should == "000000000000001" }
    it { subject["household_number"].should == "000000000000101" }
    it { subject["residents_type"].should == "1" }
    it { subject["residents_state"].should == "1" }
    it { subject["residents_code"].should == "00000000001" }
    it { subject["family_name"].should == "今居" }
    it { subject["given_name"].should == "厚" }
    it { subject["alternate_family_name"].should == "イマイ" }
    it { subject["alternate_given_name"].should == "アツシ" }
    it { subject["sex"].should == "1" }
    it { subject["age"].should == "36" }
    it { subject["date_of_birth"].to_s.should == "1998-07-14" }
    it { subject["home_state"].should == "東京都" }
    it { subject["home_city"].should == "千代田区" }
    it { subject["home_street"].should == "一ツ橋一丁目" }
    it { subject["house_number"].should == "ビル１" }
    it { subject["home_postal_code"].should == "123-4567" }
    it { subject["injury_flag"].should == "1" }
    it { subject["injury_condition"].should == "負傷内容１" }
    it { subject["allergy_flag"].should == "1" }
    it { subject["allergy_cause"].should == "アレルギー物質１" }
    it { subject["pregnancy"].should == "1" }
    it { subject["baby"].should == "1" }
    it { subject["upper_care_level_three"].should == "00" }
    it { subject["elderly_alone"].should == "0" }
    it { subject["elderly_couple"].should == "0" }
    it { subject["bedridden_elderly"].should == "0" }
    it { subject["elderly_dementia"].should == "0" }
    it { subject["rehabilitation_certificate"].should == "01" }
    it { subject["physical_disability_certificate"].should == "2" }
    it { subject["domicile"].should == "東京都千代田区一ツ橋一丁目" }
    it { subject["family_head"].should == "今居厚" }
    it { subject["created_by"].should == "user" }
    it { subject["updated_by"].should == "user" }
  end
end
