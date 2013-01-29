# -*- coding:utf-8 -*-
class JukiHistories < ActiveRecord::Migration
  def up
    create_table :juki_histories, :force => true do |t|
      t.column "number", :integer
      t.column "status", :integer
      t.column "created_by", :string, :limit => 100
      t.column "updated_by", :string, :limit => 100
      t.timestamps
    end
    
    set_column_comment(:juki_histories, :number,     "件数")
    set_column_comment(:juki_histories, :status,     "ステータス")
    set_column_comment(:juki_histories, :created_by, "登録者")
    set_column_comment(:juki_histories, :updated_by, "更新者")
    set_column_comment(:juki_histories, :created_at, "登録日時")
    set_column_comment(:juki_histories, :updated_at, "更新日時")
  end

  def down
  end
end
