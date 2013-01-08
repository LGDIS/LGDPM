# -*- coding:utf-8 -*-
class JukisController < ApplicationController
  # タブリンクのカレントタブ制御に使用
  set_tab :juki
  
  # 住基情報取込画面
  # 初期表示処理
  # ==== Args
  # ==== Return
  # ==== Raise
  def index
    @search = JukiHistory.search.order("created_at DESC")
    @juki_histories = @search.paginate(:page => params[:page], :per_page => 30)
  end
  
  # 住基情報取込画面
  # 住基CSV取込処理
  # ==== Args
  # ==== Return
  # ==== Raise
  def import
    require 'csv'
    # ファイル存在チェック
    if params[:document].blank?
      redirect_to(:action => :index)
      return 
    end
    # ファイル形式チェック
    # 非同期で処理を実行？
    file = params[:document][:file].read
    number, error_rows, error_msgs = 0, [], []
    ActiveRecord::Base.transaction do
      # 住基情報の登録
      CSV.parse(file) do |row|
        # number += 1
        # p row[0]
        # if @juki.valid?
          # @juki.save
        # else
          # ValidationErrorの場合メッセージを出力
          # error_rows << row
          # error_msgs << @juki.errors.messages
        # end
      end # <- CSV.parse
      # 住基情報取込履歴の登録
      @juki_history = JukiHistory.new
      @juki_history.number     = number
      @juki_history.status     = (error_rows.blank? ? JukiHistory::STATUS_NORMAL : JukiHistory::STATUS_ERROR)
      @juki_history.created_by = current_user.login
      @juki_history.save
    end # <- ActiveRecord::Base.transaction
    redirect_to :action => :index
  # rescue
  end
end
