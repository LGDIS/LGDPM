# -*- coding:utf-8 -*-
class States < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.integer :id
      t.string  :code
      t.string  :name
      t.timestamps
    end
    
    set_column_comment(:states, :id,   "ID")
    set_column_comment(:states, :code, "都道府県コード")
    set_column_comment(:states, :name, "都道府県名")
  end
end
