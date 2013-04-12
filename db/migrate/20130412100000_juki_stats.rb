# -*- coding:utf-8 -*-
class JukiStats < ActiveRecord::Migration
  def change
    create_table :juki_stats do |t|
      t.integer :id
      t.boolean :status, :null => false, :default => false
      
      t.timestamps
    end
    
  end
end
