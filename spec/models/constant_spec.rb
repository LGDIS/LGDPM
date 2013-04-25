# -*- coding:utf-8 -*-
require 'spec_helper'

describe Constant do
  describe "#hash_for_table" do
    subject { Constant.hash_for_table(table_name) }
    describe do
      let(:table_name) { Evacuee.table_name }
      it { subject.should be_a_kind_of(Hash) }
      it { subject["sex"].should == {"1"=>"男性", "2"=>"女性", "3"=>"その他"} }
    end
  end
end
