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
    # ファイル存在チェック
    if params[:document].blank?
      flash[:alert] = I18n.t("activerecord.errors.messages.file_not_exists")
      redirect_to(:action => :index)
      return 
    end
    # ファイル形式チェック
    if params[:document][:file].original_filename !~ /\.csv$/i
      flash[:alert] = I18n.t("activerecord.errors.messages.invalid_extension")
      redirect_to(:action => :index)
      return
    end
    # ファイル読み込み
    file = params[:document][:file].read
    require 'kconv'
    # UTF-8に変換する
    file = Kconv.toutf8(file)
    # 非同期でインポート処理を実行する
    Resque.enqueue(JukiImportJob, file, current_user.login)
    
    redirect_to :action => :index
  end
end
