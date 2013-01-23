# -*- coding:utf-8 -*-
class EvacueesController < ApplicationController
  # タブリンクのカレントタブ制御に使用
  set_tab :evacuee
  
  # 避難者一覧画面
  # 初期表示処理
  # ==== Args
  # ==== Return
  # ==== Raise
  def index
    @search = Evacuee.search(:id_eq => 0) # 取得件数0件で初期表示させるため
    @evacuees = @search.paginate(:page => params[:page], :per_page => 30)
  end

  # 避難者一覧画面
  # 検索処理
  # ==== Args
  # _params[:commit_kind]_ :: ボタン種別
  # _params[:search]_ :: 画面入力された検索条件
  # ==== Return
  # 検索ボタンが押下された場合：：検索を行い自画面に遷移する
  # 新規登録ボタンが押下された場合：：避難者登録画面に遷移する
  # 画面印刷ボタンが押下された場合：：検索を行いPDFに出力する
  # ==== Raise
  def search
    case params[:commit_kind]
    # 検索ボタン
    when "search"
      @search = Evacuee.search(params[:search])
      @evacuees = @search.paginate(:page => params[:page],
        :per_page => 30).order("alternate_family_name ASC, alternate_given_name ASC")
      render :action => :index
    # 新規登録ボタン
    when "new"
      redirect_to :action => :new
    # 画面印刷ボタン
    when "print"
      print
    # その他  
    else
      raise
    end
  end
  
  # 避難者一覧画面
  # 印刷処理
  # ==== Args
  # ==== Return
  # ==== Raise
  def print
    # !!! 暫定
    @@search        = Evacuee.search(params[:search])
    @@evacuee_const = @evacuee_const
    @@shelter       = @shelter
    
    file_name = "#{Rails.root}/tmp/sample_#{Time.now.instance_eval { '%s%06d' % [strftime('%Y%m%d%H%M%S'),  usec] }}.pdf"
    ThinReports::Report.generate_file(file_name) do
      use_layout("#{Rails.root}/lib/sample.tlf")
      start_new_page
      @@search.each do |evacuee|
        page.list(:sample_list).add_row do |row|
          row.item(:name).value("#{evacuee.family_name} #{evacuee.given_name}")
          row.item(:name_kana).value("#{evacuee.alternate_family_name} #{evacuee.alternate_given_name}")
          row.item(:address).value("#{@state[evacuee.home_state]}#{evacuee.home_city}#{evacuee.home_street}#{evacuee.house_number}")
          row.item(:city).value(@@evacuee_const["in_city_flag"]["#{evacuee.in_city_flag}"])
          if evacuee.date_of_birth.present?
            date_of_birth = evacuee.date_of_birth.strftime("%y/%m/%d")
          else
            date_of_birth = ""
          end
          row.item(:date_of_birth).value(date_of_birth)
          row.item(:shelter).value(@@shelter[evacuee.shelter_name])
          row.item(:note).value(evacuee.note)
          row.item(:juki).value(@@evacuee_const["juki_status"]["#{evacuee.juki_status}"])
          row.item(:created_by).value(evacuee.created_by)
          row.item(:created_at).value(evacuee.created_at.strftime("%y/%m/%d"))
        end
      end
    end
    send_file(file_name)
    # File.delete(file_name)
  end

  # 避難者登録画面
  # 初期表示処理
  # ==== Args
  # ==== Return
  # ==== Raise
  def new
    @evacuee = Evacuee.new
  end

  # 避難者登録画面
  # 登録処理
  # 押下されたボタンにより処理を分岐
  # ==== Args
  # ==== Return
  # ==== Raise
  def create
    if params[:commit_kind] == "save"
      @evacuee = Evacuee.new(params[:evacuee])
      if @evacuee.save
        respond_to do |format|
          format.html { redirect_to :action => :edit, :id => @evacuee.id }
          format.json { render :json => @evacuee.to_json } # LGDPM-Android
        end
      else
        respond_to do |format|
          format.html { render :action => :new }
          format.json { render :json => @evacuee.errors.messages.to_json, :status => 500 } # LGDPM-Android
        end
      end
    else
      selector
    end
  end

  # 避難者更新画面
  # 初期表示処理
  # ==== Args
  # ==== Return
  # ==== Raise
  def edit
    @evacuee = Evacuee.find(params[:id])
  end

  # 避難者更新画面
  # 更新処理
  # 押下されたボタンにより処理を分岐
  # ==== Args
  # ==== Return
  # ==== Raise
  def update
    if params[:commit_kind] == "save"
      @evacuee = Evacuee.find(params[:id])
      if @evacuee.update_attributes(params[:evacuee])
        redirect_to :action => :edit, :id => @evacuee.id
      else
        render :action => :edit, :id => @evacuee.id
      end
    else
      selector
    end
  end
  
  # 避難者登録・更新画面
  # 分岐処理
  # 保存ボタン以外の処理を記述
  # ==== Args
  # _params[:commit_kind]_ :: ボタン種別
  # _params[:id]_ :: 避難者ID
  # ==== Return
  # 削除ボタンが押下された場合：：削除を行い避難者一覧画面に遷移する
  # 住基マッチングボタンが押下された場合：：住基マッチングを行い該当者が存在する場合
  # 避難者住基マッチング候補者画面に遷移する
  # 戻るボタンが押下された場合：：避難者一覧画面に遷移する
  # ==== Raise
  def selector
    case params[:commit_kind]
    when "delete"
      @evacuee = Evacuee.find(params[:id])
      @evacuee.destroy
      redirect_to :action => :index
    when "match"
      @evacuee = Evacuee.find(params[:id])
      @jukis   = Juki.find_for_match(@evacuee)
      if @jukis.present?
        redirect_to :action => :list
      else
        @evacuee.juki_status = Evacuee::JUKI_STATUS_NA
        @evacuee.save
        render :action => :edit, :id => @evacuee.id
      end
    when "back"
      redirect_to :action => :index
    else
      raise
    end
  end
  
  # 避難者住基マッチング候補者画面
  # 初期表示処理
  # ==== Args
  # ==== Return
  # ==== Raise
  def list
    @evacuee = Evacuee.find(params[:id])
    @jukis   = Juki.find_for_match(@evacuee)
  end
  
  # 避難者住基マッチング候補者画面
  # マッチング処理
  # 押下されたボタンにより処理を分岐
  # ==== Args
  # _params[:commit_kind]_ :: ボタン種別
  # _params[:id]_ :: EvacueeID
  # ==== Return
  # 保存ボタンが押下された場合：：住基ステータスを済で更新し、避難者登録・更新画面に遷移する
  # 該当者なしボタンが押下された場合：：住基ステータスをチェック済み該当者なしで更新し、避難者登録・更新画面に遷移する
  # 戻るボタンが押下された場合：：避難者登録・更新画面に遷移する
  # ==== Raise
  def match
    @evacuee = Evacuee.find(params[:id])
    
    case params[:commit_kind]
    when "save"
      # 住基ステータスを済に更新する
      @evacuee.juki_status = Evacuee::JUKI_STATUS_COMPLETE
      @evacuee.save
      redirect_to :action => :edit, :id => @evacuee.id
    when "na"
      # 住基ステータスをチェック済み該当者なしに更新する
      @evacuee.juki_status = Evacuee::JUKI_STATUS_CHK_NA
      @evacuee.save
      redirect_to :action => :edit, :id => @evacuee.id
    when "back"
      # 避難者登録・更新画面に遷移する
      redirect_to :action => :edit, :id => @evacuee.id
    else
      raise
    end
  end
end
