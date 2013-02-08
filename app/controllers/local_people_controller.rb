# -*- coding:utf-8 -*-
# LGDPFからの避難者情報取り込み、および、取り込んだ避難者情報のEvacueeへの登録を行う
class LocalPeopleController < ApplicationController
  # タブリンクのカレントタブ制御に使用
  set_tab :local_person
  
  # 石巻PF避難者承認画面
  # 初期表示処理
  # 検索結果が0件の状態で画面を表示させる
  # ==== Args
  # _search_ :: 画面入力された検索条件
  # _page_ :: ページ番号
  # ==== Return
  # ==== Raise
  def index
    @search = LocalPerson.search(:id_eq => 0) # 取得件数0件で初期表示させるため
    @local_people = @search.paginate(:page => params[:page], :per_page => 30)
  end
  
  # 石巻PF避難者承認画面
  # 検索処理
  # 押下されたボタンにより、処理を分岐する
  # * 検索ボタンが押下された場合、検索を行い自画面に遷移する
  # * 取込ボタンが押下された場合、LGDPFから避難者情報を取得し、LocalPersonに登録する
  # * 承認ボタンが押下された場合、選択されたLocalPersonをEvacueeに登録する
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
  # Errno::ECONNREFUSED :: LGDPFに接続できなかった場合メッセージを出力する
  # ParameterException :: 承認チェックボックスが選択されていない場合メッセージを出力する
  def approval
    raise ParameterException if params[:approval_local_people].blank?
    
    ActiveRecord::Base.transaction do
      lp_ids = params[:approval_local_people].split(",")
      lp_ids.each do |id|
        local_person = LocalPerson.find(id)
        # 承認済みの場合、Evacueeに取り込まない
        next if Evacuee.find_by_local_person_id(local_person.id).present?
        # LGDPF上に存在する避難者の場合、Evacueeに取り込まない
        # LGDPMまたはLGDPM-Androidから入力し連携した避難者の場合は重複するため
        next if Evacuee.find_by_lgdpf_person_id(local_person.lgdpf_person_id).present?
        evacuee = Evacuee.new
        evacuee = evacuee.exec_insert(local_person)
        evacuee.save!
        local_person.approved_by = current_user.login
        local_person.approved_at = Time.now
        local_person.save!
      end
    end
    
  rescue ParameterException
    flash.now[:alert] = I18n.t("errors.messages.parameter_exception_approval")
  rescue Errno::ECONNREFUSED
    flash.now[:alert] = I18n.t("errors.messages.connection_refused")
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
  # Errno::ECONNREFUSED :: LGDPFに接続できなかった場合メッセージを出力する
  def import
    ActiveRecord::Base.transaction do
      # LGDPF避難者情報取得
      @people = Person.find_for_import
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
      end if @people.present?
    end
  rescue Errno::ECONNREFUSED
    flash[:alert] = I18n.t("errors.messages.connection_refused")
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
    @local_people = @search.paginate(:page => params[:page], :per_page => 30).order("alternate_names ASC")
    render :action => :index
  end
end
