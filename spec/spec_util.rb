# -*- coding:utf-8 -*-
require 'spec_helper'

def get_column(attr)
  model.connection.columns(model.class.table_name).each do |column|
    return column if column.name == attr.to_s
  end
end

shared_examples_for :presence do |attr|
  describe do
    before { model[attr] = "aaa" }
    it { model.save.should be_true }
  end
  describe do
    before { model[attr] = nil }
    it { model.save.should be_false }
  end
end

shared_examples_for :integer do |attr|
  describe do
    before { model[attr] = 123 }
    it { model.save.should be_true }
  end
  describe do
    before { model[attr] = -123 }
    it { model.save.should be_true }
  end
  describe do
    before { model[attr] = 1.047 }
    it { model.save.should be_false }
  end
  describe do
    before { model[attr] = "asdf" }
    it { model.save.should be_false }
  end
end

shared_examples_for :max_length do |attr|
  before { @column = get_column(attr) }
  
  describe do
    before { model[attr] = "a"*@column.limit }
    it { model.save.should be_true }
  end
  describe do
    before { model[attr] = "a"*(@column.limit+1) }
    it { model.save.should be_false }
  end
end

shared_examples_for :date do |attr|
  describe do
    before { model[attr] = "20120101" }
    it { model.save.should be_true }
  end
  describe do
    before { model[attr] = "2012-1-1" }
    it { model.save.should be_true }
  end
  describe do
    before { model[attr] = "2012-01-01" }
    it { model.save.should be_true }
  end
  describe do
    before { model[attr] = "2012.01.01" }
    it { model.save.should be_true }
  end
  describe do
    before { model[attr] = "2012-01-01" }
    it { model.save.should be_true }
  end
  describe do
    before { model[attr] = "2012/02/31" }
    it { model.save.should be_false }
  end
  describe do
    before { model[attr] = "aaaa" }
    it { model.save.should be_false }
  end
  describe do
    before { model[attr] = "123" }
    it { model.save.should be_false }
  end
end

shared_examples_for :datetime do |attr|
  describe do
    before { model[attr] = "20120101 123456" }
    it { model.save.should be_true }
  end
  describe do
    before { model[attr] = "2012-1-1 12:34:56" }
    it { model.save.should be_true }
  end
  describe do
    before { model[attr] = "2012-01-01 12:34:56" }
    it { model.save.should be_true }
  end
  describe do
    before { model[attr] = "2012.01.01 12:34:56" }
    it { model.save.should be_true }
  end
  describe do
    before { model[attr] = "2012-01-01 12:34:56" }
    it { model.save.should be_true }
  end
  describe do
    before { model[attr] = "2012/02/31 12:34:56" }
    it { model.save.should be_false }
  end
  describe do
    before { model[attr] = "2012/02/01 26:87:82" }
    it { model.save.should be_false }
  end
  describe do
    before { model[attr] = "aaaa" }
    it { model.save.should be_false }
  end
  describe do
    before { model[attr] = "123" }
    it { model.save.should be_false }
  end
end

shared_examples_for :check_value_for_string do |attr|
  describe "#{attr}" do
    describe "integer" do
      let(:value) { 1 }
      before { param[attr] = value }
      it { subject; model[attr].should == value }
    end
    describe "string" do
      let(:value) { "a" }
      before { param[attr] = value }
      it { subject; model[attr].should == value }
    end
    describe "nil" do
      let(:value) { nil }
      before { param[attr] = value }
      it { subject; model[attr].should == value }
    end
  end
end

shared_examples_for :check_value_for_integer do |attr|
  describe "#{attr}" do
    describe "integer" do
      let(:value) { 1 }
      before { param[attr] = value }
      it { subject; model[attr].should == value }
    end
    describe "nil" do
      let(:value) { nil }
      before { param[attr] = value }
      it { subject; model[attr].should == value }
    end
  end
end

shared_examples_for :check_value_for_date do |attr|
  describe "#{attr}" do
    describe "date" do
      let(:value) { "2012-04-12" }
      before { param[attr] = value }
      it { subject; model[attr].to_s.should == value }
    end
    describe "nil" do
      let(:value) { nil }
      before { param[attr] = value }
      it { subject; model[attr].should == value }
    end
  end
end

shared_examples_for :find_for_match do |evacuee_attr, juki_attr, val|
  describe "#{attr}" do
    before(:each) do
      evacuee.update_attributes(evacuee_attr => val)
      juki.update_attributes(juki_attr => val)
    end
    it { subject.size.should == 1 }
    it { subject.first[juki_attr].to_s.should == val }
  end
end
