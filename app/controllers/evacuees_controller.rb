# -*- coding:utf-8 -*-
# 避難者の管理、住基情報とのマッチングを行う
class EvacueesController < ApplicationController
  # タブリンクのカレントタブ制御に使用
  set_tab :evacuee
  
  # 避難者一覧画面
  # 初期表示処理
  # 検索結果が0件の状態で画面を表示させる
  # ==== Args
  # _page_ :: ページ番号
  # ==== Return
  # ==== Raise
  def index
    respond_to do |format|
      format.html {
        @search = Evacuee.search(:id_eq => 0) # 取得件数0件で初期表示させるため
        @evacuees = @search.paginate(:page => params[:page], :per_page => 30)
        render :index
      }
      # 災害トラッキング管理機能(LGDIS)との連携のため
      format.json{
        @evacuees = Evacuee.find_for_count
        render :json => @evacuees.to_json
      }
    end
  end

  # 避難者一覧画面
  # 検索処理
  # 押下されたボタンにより、処理を分岐する
  # * 検索ボタンが押下された場合、検索を行い自画面に遷移する
  # * 新規登録ボタンが押下された場合、避難者登録画面に遷移する
  # * 画面印刷ボタンが押下された場合、検索を行いPDFに出力する
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
    # 集計ボタン
    when "total"
      total
    # その他  
    else
      raise
    end
  end
  
  # 避難者一覧画面
  # 印刷処理
  # 検索条件に合致する避難者情報を全件PDFに出力する
  # ==== Args
  # _search_ :: 画面入力された検索条件
  # _page_ :: ページ番号
  # ==== Return
  # ==== Raise
  def print
    @search   = Evacuee.search(params[:search])
    @evacuees = @search.paginate(:page => params[:page])
    # 避難者情報が存在しない場合、出力しない
    if @evacuees.blank?
      flash[:alert] = I18n.t("errors.messages.evacuees_not_exists")
      render :action => :index
      return
    end
    # 避難者を避難所単位に分ける
    evacuees_list = {}
    @search.each do |evacuee|
      shelter = Rails.cache.read("shelter")[evacuee.shelter_name]
      shelter_name = (shelter.blank? ? "避難所なし" : shelter["name"])
      evacuees_list[shelter_name] = {} unless evacuees_list[shelter_name]
      evacuees_list[shelter_name][evacuee.id] = evacuee
    end
    # 避難所単位でpdfを生成する
    reports = {}
    evacuees_list.each_pair do |shelter_name, evacuees_hash|
      report = ThinReports::Report.new layout: File.join(Rails.root, 'lib', 'sample.tlf')
      evacuees_hash.each_pair do |id, evacuee|
        report.list(:sample_list).add_row do |row|
          row.values name:          "#{evacuee.family_name} #{evacuee.given_name}",
                     name_kana:     "#{evacuee.alternate_family_name} #{evacuee.alternate_given_name}",
                     address:       "#{@state[evacuee.home_state]}#{evacuee.home_city}#{evacuee.home_street}#{evacuee.house_number}",
                     city:          @evacuee_const["in_city_flag"]["#{evacuee.in_city_flag}"],
                     date_of_birth: (evacuee.date_of_birth.present? ? evacuee.date_of_birth.strftime("%y/%m/%d") : ""),
                     shelter:       @shelter[evacuee.shelter_name],
                     note:          evacuee.note,
                     juki:          @evacuee_const["juki_status"]["#{evacuee.juki_status}"],
                     created_by:    evacuee.created_by,
                     created_at:    evacuee.created_at.strftime("%y/%m/%d")
        end
      end
      reports[shelter_name] = report
    end
    # pdfを生成する
    files = {}
    reports.each_pair do |shelter_name, report|
      files[NKF.nkf('-sxm0', "#{shelter_name}.pdf")] = report.generate
    end
    # 生成されたpdfをzipで圧縮する
    buf = ''
    Zip::Archive.open_buffer(buf, Zip::CREATE) do |archive|
      files.each_pair do |filename, filestream|
        archive.add_buffer(NKF.nkf('-sxm0', filename), filestream)
      end
    end
    # zipを出力する
    send_data(buf, filename: "避難者一覧_#{Time.now.instance_eval {'%s%06d' % [strftime('%Y%m%d%H%M%S'),usec]}}.zip",
      type: "application/zip", disposition: "attached")
  end
  
  # 避難者一覧画面
  # 集計処理
  # 避難者情報を集計しLGDISに連携する
  # ==== Args
  # _search_ :: 画面入力された検索条件
  # _page_ :: ページ番号
  # ==== Return
  # ==== Raise
  def total
    # ルーティング上プロジェクト識別子が必要
    project = Project.find(:first)
    raise ParameterException if project.blank?
    
    shelters = Shelter.find(:all, :params => { project_id: project.identifier })
    
    Evacuee.find_for_count.each do |result|
      # 避難所識別番号が一致する避難所を取得
      index = shelters.rindex{|s| s.shelter_code == result.shelter_name }
      next if index.blank?
      shelter = shelters[index]
      # 人数（自主避難人数を含む）
      shelter.head_count = result["head_count"]
      # 世帯数（自主避難世帯数を含む）
      # shelter.households = result["households_count"]
      # 負傷_計
      shelter.injury_count = result["injury_flag_count"]
      # 要介護度3以上_計
      shelter.upper_care_level_three_count = result["upper_care_level_three_count"]
      # 一人暮らし高齢者（65歳以上）_計
      shelter.elderly_alone_count = result["elderly_alone_count"]
      # 高齢者世帯（夫婦共に65歳以上）_計
      shelter.elderly_couple_count = result["elderly_couple_count"]
      # 寝たきり高齢者_計
      shelter.bedridden_elderly_count = result["bedridden_elderly_count"]
      # 認知症高齢者_計
      shelter.elderly_dementia_count = result["elderly_dementia_count"]
      # 療育手帳所持者_計
      shelter.rehabilitation_certificate_count = result["rehabilitation_certificate_count"]
      # 身体障害者手帳所持者_計
      shelter.physical_disability_certificate_count = result["physical_disability_certificate_count"]
      shelter.save
    end
    
  rescue ParameterException
    flash.now[:alert] = I18n.t("errors.messages.projects_not_exists")
  rescue ActiveResource::ServerError, ActiveResource::UnauthorizedAccess => e
    flash.now[:alert] = "#{e}"
  rescue Errno::ECONNREFUSED
    flash.now[:alert] = I18n.t("errors.messages.connection_refused")
  ensure
    @search = Evacuee.search(params[:search])
    @evacuees = @search.paginate(:page => params[:page],
      :per_page => 30).order("alternate_family_name ASC, alternate_given_name ASC")
    render :action => :index
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
  # 押下されたボタンにより、処理を分岐する
  # * 保存ボタンが押下された場合、保存を行い自画面に遷移する
  # * その他の場合、selectorメソッドに委譲する
  # LGDPM-Androidからのアップロードに対応するため、json形式のリクエストを許可する
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
          format.json { render :text => @evacuee.errors.full_messages, :status => :internal_server_error } # LGDPM-Android
        end
      end
    else
      selector
    end
  end

  # 避難者更新画面
  # 初期表示処理
  # ==== Args
  # _id_ :: EvacueeID
  # ==== Return
  # ==== Raise
  def edit
    @evacuee = Evacuee.find(params[:id])
    @jukis   = Juki.find_for_family(@evacuee) if @evacuee.family_well == Evacuee::FAMILY_WELL_ON
  end

  # 避難者更新画面
  # 更新処理
  # 押下されたボタンにより、処理を分岐する
  # * 保存ボタンが押下された場合、保存を行い自画面に遷移する
  # * その他の場合、selectorメソッドに委譲する
  # ==== Args
  # _id_ :: EvacueeID
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
  # * 削除ボタンが押下された場合、削除を行い避難者一覧画面に遷移する
  # * 住基マッチングボタンが押下された場合、住基マッチングを行い該当者が存在する場合、避難者住基マッチング候補者画面に遷移する
  # * 戻るボタンが押下された場合、避難者一覧画面に遷移する
  # * その他の場合、例外を発生させる
  # ==== Args
  # _commit_kind_ :: ボタン種別
  # _id_ :: 避難者ID
  # _pattern_ :: 検索対象項目の配列
  # ==== Return
  # ==== Raise
  def selector
    case params[:commit_kind]
    when "delete"
      @evacuee = Evacuee.find(params[:id])
      @evacuee.destroy
      redirect_to :action => :index
    when "match"
      @evacuee = Evacuee.find(params[:id])
      if @evacuee.matching(params[:pattern]).present?
        redirect_to :action => :list, :id => @evacuee.id, :pattern => params[:pattern]
      else
        @evacuee.update_attributes(:juki_status => Evacuee::JUKI_STATUS_CHK_NA)
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
  # 氏名カナ、生年月日が一致する住基情報一覧を表示する
  # ==== Args
  # _id_ :: EvacueeID
  # _pattern_ :: 検索対象項目の配列
  # ==== Return
  # ==== Raise
  def list
    @evacuee = Evacuee.find(params[:id])
    @jukis   = @evacuee.matching(params[:pattern])
  end
  
  # 避難者住基マッチング候補者画面
  # マッチング処理
  # 押下されたボタンにより処理を分岐
  # * 保存ボタンが押下された場合、住基ステータスを照合済で更新し、避難者登録・更新画面に遷移する
  # * 突合実施後戻るボタンが押下された場合、住基ステータスを照合済対象者なしで更新し、避難者登録・更新画面に遷移する
  # * 戻るボタンが押下された場合、避難者登録・更新画面に遷移する
  # ==== Args
  # _commit_kind_ :: ボタン種別
  # _id_ :: EvacueeID
  # _juki_id_ :: JukiID
  # ==== Return
  # ==== Raise
  def match
    # TODO
    # 家族も無事
    # 住基情報とのマージ
    @evacuee = Evacuee.find(params[:id])
    case params[:commit_kind]
    when "save"
      juki = Juki.find(params[:juki_id])
      # 住基ステータスを照合済に更新する
      @evacuee.update_attributes(:juki_status => Evacuee::JUKI_STATUS_COMPLETE, :juki_number => juki.id_number, :household_number => juki.household_number)
      redirect_to :action => :edit, :id => @evacuee.id
    when "na"
      # 住基ステータスを照合済対象者なしに更新する
      @evacuee.update_attributes(:juki_status => Evacuee::JUKI_STATUS_CHK_NA)
      redirect_to :action => :edit, :id => @evacuee.id
    when "back"
      # 避難者登録・更新画面に遷移する
      redirect_to :action => :edit, :id => @evacuee.id
    else
      raise
    end
  end
end
