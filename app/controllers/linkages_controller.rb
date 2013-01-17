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
  # 連携ボタンが押下された場合：：選択されたEvacueeをLGDPFに登録する
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
  # _params[:link_evacuees]_ :: 連携チェックされた避難者ID配列
  # ==== Return
  # ==== Raise
  def link
    # TODO 連携済みの場合、再連携したときの動きを検討する
    if params[:link_evacuees].present?
      ActiveRecord::Base.transaction do
        evacuee_ids = params[:link_evacuees].split(",")
        evacuee_ids.each do |id|
          evacuee = Evacuee.find(id)
          # 入力元システムを判定する
          ### evacuee.local_person_idがブランクの場合
          ##### LGDPMまたはLGDPM-Androidから入力した避難者情報
          ##### 避難者情報がLGDPF上に存在しないため、避難者情報および安否情報を登録する
          ### 上記以外の場合
          ###### GooglePersonFinderまたはLGDPFから入力した避難者情報
          ###### 避難者情報がLGDPF上に存在するため、安否情報のみを登録する
          if evacuee.local_person_id.blank?
            # LGDPF上に存在しない場合
            # 避難者情報登録
            person = Person.new
            person = person.exec_insert(evacuee)
            person.save
            
            evacuee.lgdpf_person_id = person.id
            
            # 安否情報登録
            note = Note.new
            note = note.exec_insert(evacuee)
            note.save
          else
            # LGDPF上に存在する場合
            # 安否情報登録
            note = Note.new
            note = note.exec_insert(evacuee)
            note.save
          end
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
