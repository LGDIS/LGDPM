# -*- coding:utf-8 -*-
require 'spec_helper'

describe Evacuee do
  fixtures :all
  
  describe "Validation" do
    before :each do
      @evacuee = Evacuee.new
      @evacuee.family_name = "family_name"
      @evacuee.given_name = "given_name"
    end
    
    it "should success" do
      @evacuee.save.should be_true
    end
    
    describe "family_name" do
      before :each do
        @evacuee.family_name = nil
      end
      it "should validation error" do
        @evacuee.save.should be_false
      end
    end
    
    describe "given_name" do
      before :each do
        @evacuee.given_name = nil
      end
      it "should validation error" do
        @evacuee.save.should be_false
      end
    end
  end
end
