# -*- coding:utf-8 -*-
# 避難者情報の検索、LGDPFへの連携を行う
class LinkagesController < ApplicationController
  # タブリンクのカレントタブ制御に使用
  set_tab :linkage
  
  # 石巻PF避難者連携画面
  # 初期表示処理
  # ==== Args
  # _page_ :: ページ番号
  # ==== Return
  # ==== Raise
  def index
    @search = Evacuee.search
    @evacuees = @search.paginate(:page => params[:page])
  end
  
  # 石巻PF避難者連携画面
  # 検索処理
  # 押下されたボタンにより、処理を分岐する
  # * 検索ボタンが押下された場合、検索を行い自画面に遷移する
  # * 連携ボタンが押下された場合、linkメソッドに委譲する
  # * その他の場合、例外を発生させる
  # ==== Args
  # _commit_kind_ :: ボタン種別
  # _search_ :: 画面入力された検索条件
  # _page_ :: ページ番号
  # ==== Return
  # ==== Raise
  def search
    case params[:commit_kind]
    # 検索ボタン
    when "search"
      do_search
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
  # 引数で渡されたEvacueeIDを元に避難者情報を取得しLGDPFへの連携を行う
  # 該当の避難者がLGDPMに登録済みかどうか判断し、処理を分岐する
  # Evacuee.lgdpf_person_idがブランクの場合
  #  LGDPMまたはLGDPM-Androidから入力されたと判断する
  #  避難者情報がLGDPF上に存在しないため、避難者情報および安否情報を登録する
  # Evacuee.lgdpf_person_idがブランクでない場合
  #  GooglePersonFinderまたはLGDPFから入力されたと判断する
  #  避難者情報がLGDPF上に存在するため、安否情報のみを登録する
  # ==== Args
  # _link_evacuees :: 連携チェックされたEvacueeID配列
  # ==== Return
  # ==== Raise
  # ActiveResource::ServerError :: LGDPFで保存に失敗した場合メッセージを出力する
  # ParameterException :: 連携チェックボックスが選択されていない場合メッセージを出力する
  # Errno::ECONNREFUSED :: LGDPFに接続できなかった場合メッセージを出力する
  def link
    raise ParameterException if params[:link_evacuees].blank?
    
    evacuee_ids = params[:link_evacuees].split(",")
    evacuee_ids.each do |id|
      evacuee = Evacuee.find(id)
      # 入力元システムを判定する
      if evacuee.lgdpf_person_id.blank?
        # LGDPF上に存在しない場合
        # 避難者情報登録
        person = Person.new
        person = person.exec_insert(evacuee)
        person.save
        # LGDPF IDの更新
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
      # 連携実施者、連携日時の更新
      evacuee.linked_by   = current_user.login
      evacuee.linked_at   = Time.now
      evacuee.linked_flag = Evacuee::LINKED_FLAG_ON
      evacuee.save!
    end
    flash.now[:notice] = I18n.t("notice_successful_link")
  rescue ActiveResource::ServerError => e
    flash.now[:alert] = "#{e}"
  rescue ParameterException
    flash.now[:alert] = I18n.t("errors.messages.parameter_exception_link")
  rescue Errno::ECONNREFUSED
    flash.now[:alert] = I18n.t("errors.messages.connection_refused")
  ensure
    do_search
  end
  
  private
  # 画面入力された検索条件を元に、検索を実行する
  # ==== Args
  # _search_ :: 画面入力された検索条件
  # _page_ :: ページ番号
  # ==== Return
  # ==== Raise
  def do_search
    @search = Evacuee.search(params[:search])
    @evacuees = @search.paginate(:page => params[:page])
    render :action => :index
  end
end
