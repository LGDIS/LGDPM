# -*- coding:utf-8 -*-
class LinkagesController < ApplicationController
  # タブリンクのカレントタブ制御に使用
  set_tab :linkage
  
  # 石巻PF避難者連携画面
  # 初期表示処理
  # ==== Args
  # ==== Return
  # ==== Raise
  def index
    @search = Evacuee.search(:id_eq => 0) # 取得件数0件で初期表示させるため
    @evacuees = @search.paginate(:page => params[:page], :per_page => 30)
  end
  
  # 石巻PF避難者連携画面
  # 検索処理
  # ==== Args
  # _params[:commit_kind]_ :: ボタン種別
  # _params[:search]_ :: 画面入力された検索条件
  # ==== Return
  # 検索ボタンが押下された場合：：検索を行い自画面に遷移する
  # 連携ボタンが押下された場合：：LPFに連携を行い自画面に遷移する
  # ==== Raise
  def search
    case params[:commit_kind]
    # 検索ボタン
    when "search"
      @search = Evacuee.search(params[:search])
      @evacuees = @search.paginate(:page => params[:page], :per_page => 30)
      render :action => :index
    # 連携ボタン
    when "link"
      link
    # その他  
    else
      raise
    end
  end
  
  # 石巻PF避難者連携画面
  # 連携処理
  # ==== Args
  # ==== Return
  # ==== Raise
  def link
    # 連携チェックした避難者ID
    # params[:link_evacuees]
    if params[:link_evacuees].present?
      ActiveRecord::Base.transaction do
        evacuee_ids = params[:link_evacuees].split(",")
        evacuee_ids.each do |id|
          evacuee = Evacuee.find(id)
          evacuee.linked_by = current_user.login
          evacuee.linked_at = Time.now
          evacuee.save!
        end
      end
    end
    
    @search = Evacuee.search(params[:search])
    @evacuees = @search.paginate(:page => params[:page], :per_page => 30)
    render :action => :index
  end
end
