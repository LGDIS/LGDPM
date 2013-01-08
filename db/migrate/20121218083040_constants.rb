# -*- coding:utf-8 -*-
class Constants < ActiveRecord::Migration
  def up
    create_table :constants, :force => true do |t|
      t.column "kind1",  :string
      t.column "kind2",  :string
      t.column "kind3",  :string
      t.column "text",   :string
      t.column "value",  :string
      t.column "_order", :integer
      t.timestamps
    end
    
    set_column_comment(:constants, :kind1,      "種別")
    set_column_comment(:constants, :kind2,      "テーブル名")
    set_column_comment(:constants, :kind3,      "カラム名")
    set_column_comment(:constants, :text,       "テキスト")
    set_column_comment(:constants, :value,      "値")
    set_column_comment(:constants, :_order,     "並び順")
    set_column_comment(:constants, :created_at, "登録日時")
    set_column_comment(:constants, :updated_at, "更新日時")
  end

  def down
  end
end
