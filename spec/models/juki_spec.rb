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
    it_should_behave_like :max_length, :year_number
    it_should_behave_like :max_length, :relation1
    it_should_behave_like :max_length, :relation2
    it_should_behave_like :max_length, :relation3
    it_should_behave_like :max_length, :relation4
    it_should_behave_like :max_length, :household_family_name
    it_should_behave_like :max_length, :household_given_name
    it_should_behave_like :max_length, :household_alternate_family_name
    it_should_behave_like :max_length, :household_alternate_given_name
    it_should_behave_like :max_length, :address_code
    it_should_behave_like :max_length, :address
    it_should_behave_like :max_length, :building_name
    it_should_behave_like :max_length, :postal_code
    it_should_behave_like :max_length, :former_address_code
    it_should_behave_like :max_length, :former_address
    it_should_behave_like :max_length, :former_building_name
    it_should_behave_like :max_length, :former_postal_code
    it_should_behave_like :max_length, :new_address_code
    it_should_behave_like :max_length, :new_address
    it_should_behave_like :max_length, :new_building_name
    it_should_behave_like :max_length, :new_postal_code
    it_should_behave_like :max_length, :new_address_division
    it_should_behave_like :max_length, :domicile
    it_should_behave_like :max_length, :domicile_code
    it_should_behave_like :max_length, :family_head
    it_should_behave_like :max_length, :became_change_reason
    it_should_behave_like :max_length, :decided_change_reason
    it_should_behave_like :max_length, :lost_change_reason
    it_should_behave_like :max_length, :original_area
    it_should_behave_like :max_length, :change_division
    it_should_behave_like :max_length, :change_reason
    it_should_behave_like :max_length, :created_by
    it_should_behave_like :max_length, :updated_by
    
    it_should_behave_like :date, :date_of_birth
    it_should_behave_like :date, :became_change_date
    it_should_behave_like :date, :became_report_date
    it_should_behave_like :date, :decided_change_date
    it_should_behave_like :date, :decided_report_date
    it_should_behave_like :date, :lost_change_date
    it_should_behave_like :date, :lost_report_date
    
    it_should_behave_like :datetime, :change_date
  end
  
  describe "#find_for_match" do
    subject { Juki.find_for_match(evacuee) }
    let(:evacuee) { FactoryGirl.create(:evacuee) }
    let(:juki) { FactoryGirl.create(:juki) }
    before(:each) do
      FactoryGirl.create(:juki)
      j = FactoryGirl.create(:juki)
      j.update_attributes(:alternate_family_name => "aaaaa", :alternate_given_name => "bbbbb",
        :date_of_birth => "2012-12-24", :sex => "2", :address => "poiuytrewq")
    end
    
    it_should_behave_like :find_for_match, :alternate_family_name, :alternate_family_name, "abc"
    it_should_behave_like :find_for_match, :alternate_given_name, :alternate_given_name, "efg"
    it_should_behave_like :find_for_match, :date_of_birth, :date_of_birth, "2013-01-02"
    it_should_behave_like :find_for_match, :sex, :sex, "1"
    it_should_behave_like :find_for_match, :home_state, :address, "qwer"
    it_should_behave_like :find_for_match, :home_city, :address, "asdf"
    it_should_behave_like :find_for_match, :home_street, :address, "zxcv"
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
      "今居　厚", # row[5]
      "イマイ　アツシ", # row[6]
      "1", # row[7]
      "01", # row[8]
      "1880", # row[9]
      "01", # row[10]
      "01", # row[11]
      "01", # row[12]
      "20", # row[13]
      "38", # row[14]
      "41", # row[15]
      "毒島　隆三郎", # row[16]
      "ブスジマ　リュウザブロウ", # row[17]
      "000000000000000000000000000001", # row[18]
      "東京都千代田区一ツ橋一丁目", # row[19]
      "ビル１", # row[20]
      "200-1001", # row[21]
      "000000000000000000000000000335", # row[22]
      "石川県金沢市いなほ一丁目", # row[23]
      "ビル１０１", # row[24]
      "100-9001", # row[25]
      "000000000000000000000000075398", # row[26]
      "三重県津市北町津", # row[27]
      "ビル２０１", # row[28]
      "300-0101", # row[29]
      "1", # row[30]
      "福岡県北九州市門司区大字小森江", # row[31]
      "000000000000000000000000000001", # row[32]
      "マクダーモット　澤子", # row[33]
      "1700", # row[34]
      "12", # row[35]
      "01", # row[36]
      "2000", # row[37]
      "01", # row[38]
      "02", # row[39]
      "01", # row[40]
      "2100", # row[41]
      "07", # row[42]
      "11", # row[43]
      "1500", # row[44]
      "09", # row[45]
      "16", # row[46]
      "01", # row[47]
      "1600", # row[48]
      "01", # row[49]
      "16", # row[50]
      "1700", # row[51]
      "01", # row[52]
      "16", # row[53]
      "01", # row[54]
      "1800", # row[55]
      "01", # row[56]
      "16", # row[57]
      "00", # row[58]
      "00", # row[59]
      "00", # row[60]
      "独自領域１", # row[61]
      "0", # row[62]
      "1"# row[63]
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
    it { subject["year_number"].should == "01" }
    it { subject["date_of_birth"].to_s.should == "1880-01-01" }
    it { subject["relation1"].should == "01" }
    it { subject["relation2"].should == "20" }
    it { subject["relation3"].should == "38" }
    it { subject["relation4"].should == "41" }
    it { subject["household_family_name"].should == "毒島" }
    it { subject["household_given_name"].should == "隆三郎" }
    it { subject["household_alternate_family_name"].should == "ブスジマ" }
    it { subject["household_alternate_given_name"].should == "リュウザブロウ" }
    it { subject["address_code"].should == "000000000000000000000000000001" }
    it { subject["address"].should == "東京都千代田区一ツ橋一丁目" }
    it { subject["building_name"].should == "ビル１" }
    it { subject["postal_code"].should == "200-1001" }
    it { subject["former_address_code"].should == "000000000000000000000000000335" }
    it { subject["former_address"].should == "石川県金沢市いなほ一丁目" }
    it { subject["former_building_name"].should == "ビル１０１" }
    it { subject["former_postal_code"].should == "100-9001" }
    it { subject["new_address_code"].should == "000000000000000000000000075398" }
    it { subject["new_address"].should == "三重県津市北町津" }
    it { subject["new_building_name"].should == "ビル２０１" }
    it { subject["new_postal_code"].should == "300-0101" }
    it { subject["new_address_division"].should == "1" }
    it { subject["domicile"].should == "福岡県北九州市門司区大字小森江" }
    it { subject["domicile_code"].should == "000000000000000000000000000001" }
    it { subject["family_head"].should == "マクダーモット　澤子" }
    it { subject["became_change_date"].to_s.should == "1700-12-01" }
    it { subject["became_report_date"].to_s.should == "2000-01-02" }
    it { subject["became_change_reason"].should == "01" }
    it { subject["decided_change_date"].to_s.should == "2100-07-11" }
    it { subject["decided_report_date"].to_s.should == "1500-09-16" }
    it { subject["decided_change_reason"].should == "01" }
    it { subject["lost_change_date"].to_s.should == "1600-01-16" }
    it { subject["lost_report_date"].to_s.should == "1700-01-16" }
    it { subject["lost_change_reason"].should == "01" }
    it { subject["change_date"].to_s.should == "1800-01-16 00:00:00 +0918" }
    it { subject["original_area"].should == "独自領域１" }
    it { subject["change_division"].should == "0" }
    it { subject["change_reason"].should == "1" }
    it { subject["created_by"].should == "user" }
    it { subject["updated_by"].should == "user" }
  end
  
end
