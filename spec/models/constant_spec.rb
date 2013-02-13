# -*- coding:utf-8 -*-
require 'spec_helper'

describe Constant do
  describe "#hash_for_table" do
    subject { Constant.hash_for_table(table_name) }
    describe do
      let(:table_name) { LocalPerson.table_name }
      it { subject.should be_a_kind_of(Hash) }
      it { subject.should == {"status"=>{"1"=>"指定なし", "2"=>"情報を探している", "3"=>"私が本人である", "4"=>"この人が生きているという情報を入手した", "5"=>"この人を行方不明と判断した理由がある"}} }
    end
  end
end
