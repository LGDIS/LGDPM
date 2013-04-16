# -*- coding:utf-8 -*-
class JukiStats < ActiveRecord::Migration
  def change
    create_table :juki_stats do |t|
      t.integer :id
      t.integer :status, :null => false, :default => 0
      
      t.timestamps
    end
    
  end
end
