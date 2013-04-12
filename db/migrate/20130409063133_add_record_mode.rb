# -*- coding: utf-8 -*-
class AddRecordMode < ActiveRecord::Migration
  def change
    add_column :evacuees, :record_mode, :integer, :null => false, :default => 0
    add_column :shelters, :record_mode, :integer, :null => false, :default => 0

    set_column_comment(:evacuees, :record_mode, "記録種別")
    set_column_comment(:shelters, :record_mode, "記録種別")
  end
end
