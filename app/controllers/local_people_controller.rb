# -*- coding:utf-8 -*-
# LGDPFからの避難者情報取り込み、および、取り込んだ避難者情報のEvacueeへの登録を行う
class LocalPeopleController < ApplicationController
  # タブリンクのカレントタブ制御に使用
  set_tab :local_person
  
  # 石巻PF避難者承認画面
  # 初期表示処理
  # ==== Args
  # _search_ :: 画面入力された検索条件
  # _page_ :: ページ番号
  # ==== Return
  # ==== Raise
  def index
    @search = LocalPerson.search
    @local_people = @search.paginate(:page => params[:page])
  end
  
  # 石巻PF避難者承認画面
  # 検索処理
  # 押下されたボタンにより、処理を分岐する
  # * 検索ボタンが押下された場合、検索を行い自画面に遷移する
  # * 取込ボタンが押下された場合、LGDPFから避難者情報を取得し、LocalPersonに登録する
  # * 承認ボタンが押下された場合、選択されたLocalPersonをEvacueeに登録する
  # * 承認ボタンが押下された場合、すべてのLocalPersonをEvacueeに登録する
  # * その他の場合、例外を発生させる
  # ==== Args
  # _commit_kind_ :: ボタン種別
  # ==== Return
  # ==== Raise
  def search
    case params[:commit_kind]
    when "search" # 検索ボタン
      do_search
    when "approval" # 承認ボタン
      approval
    when "bulk_approval" # 一括承認ボタン
      bulk_approval
    when "import" # 取込ボタン
      import
    else # その他
      raise
    end
  end
  
  # 石巻PF避難者承認画面
  # 承認処理
  # 承認チェックボックスで選択された避難者をEvacueeに登録する
  # ただし、登録済みの場合は処理しない
  # 承認処理後、検索を行い検索結果を表示する
  # ==== Args
  # _approval_local_people_ :: LocalPersonID配列
  # ==== Return
  # ==== Raise
  # ParameterException :: 承認チェックボックスが選択されていない場合メッセージを出力する
  def approval
    raise ParameterException if params[:approval_local_people].blank?
    
    ActiveRecord::Base.transaction do
      LocalPerson.exec_approval(params[:approval_local_people].split(","), current_user)
    end
    
    flash.now[:notice] = I18n.t("notice_successful_approval")
  rescue ParameterException
    flash.now[:alert] = I18n.t("errors.messages.parameter_exception_approval")
  ensure
    do_search
  end
  
  # 石巻PF避難者承認画面
  # 一括承認処理
  # すべての避難者をEvacueeに登録する
  # ただし、登録済みの場合は処理しない
  # 承認処理後、検索を行い検索結果を表示する
  # ==== Args
  # ==== Return
  # ==== Raise
  def bulk_approval
    ActiveRecord::Base.transaction do
      local_people = LocalPerson.select(:id).where(:approved_flag => LocalPerson::APPROVED_FLAG_OFF)
      LocalPerson.exec_approval(local_people.map{|p| p.id }, current_user)
    end
    
    flash.now[:notice] = I18n.t("notice_successful_approval")
  ensure
    do_search
  end
  
  # 石巻PF避難者承認画面
  # 避難者情報取込処理
  # LGDPFとREST I/Fにて連携を行い、避難者情報を取得する
  # 取得した避難者情報を元に安否情報を取得する
  # 避難者情報、安否情報をLocalPersonへ登録する
  # 避難者情報、安否情報の連携フラグを更新し、再連携させないようにする
  # 取込処理後、検索を行い検索結果を表示する
  # ==== Args
  # ==== Return
  # ==== Raise
  # ActiveResource::ServerError :: LGDPFで保存に失敗した場合メッセージを出力する
  # Errno::ECONNREFUSED :: LGDPFに接続できなかった場合メッセージを出力する
  def import
    # LGDPF避難者情報取得
    @people = Person.find_for_import
    raise ParameterException if @people.blank?
    
    @people.each do |person|
      # LocalPersonへ登録
      local_person = LocalPerson.new
      local_person = local_person.exec_insert(person)
      # LGDPF安否情報取得
      note = Note.find_for_import(person).first
      local_person.status = note.try(:status)
      local_person.last_known_location = note.try(:last_known_location)
      local_person.save!
      # 連携フラグ更新
      person.update_attributes(:link_flag => true)
      note.update_attributes(:link_flag => true) unless note.blank?
    end
    
    flash.now[:notice] = I18n.t("notice_successful_import")
  rescue ParameterException
    flash.now[:alert] = I18n.t("errors.messages.evacuees_not_exists")
  rescue ActiveResource::ServerError => e
    flash.now[:alert] = "#{e}"
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
    @search = LocalPerson.search(params[:search])
    @local_people = @search.paginate(:page => params[:page]).order("created_at DESC")
    render :action => :index
  end
end
