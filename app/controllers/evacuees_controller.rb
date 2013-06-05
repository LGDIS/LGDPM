# -*- coding:utf-8 -*-
# 避難者の管理、住基情報とのマッチングを行う
class EvacueesController < ApplicationController
  # タブリンクのカレントタブ制御に使用
  set_tab :evacuee
  set_tab :register, :only => [:new, :create]

  # 避難者一覧画面
  # 初期表示処理
  # ==== Args
  # _search_ :: 画面入力された検索条件
  # _page_ :: ページ番号
  # ==== Return
  # ==== Raise
  def index

    if !params.nil? and !params[:search].nil? and !params[:search][:meta_sort].nil? then

        meta_sort = params[:search][:meta_sort]
        meta_sort_array = meta_sort.split(".")

        if meta_sort_array[0] == "shelter_name" then
          convert_null_value = "''"

          params[:search].delete('meta_sort')
          @search   = Evacuee.mode_in().search(params[:search])
          @evacuees = @search.order("CASE WHEN #{meta_sort_array[0]} IS NULL THEN #{convert_null_value} ELSE #{meta_sort_array[0]} END #{meta_sort_array[1]}").order(:alternate_family_name, :alternate_given_name).paginate(:page => params[:page])

          #退避させておいた状態を元に戻す
          params[:search]['meta_sort'] = meta_sort
          @search   = Evacuee.mode_in().search(params[:search])
        elsif meta_sort_array[0] == "alternate_family_name_and_alternate_given_name" then
          convert_null_value = "''"
          meta_sort_title_array = meta_sort_array[0].split("_and_")

          params[:search].delete('meta_sort')
          @search   = Evacuee.mode_in().search(params[:search])
          @evacuees = @search.order("CASE WHEN #{meta_sort_title_array[0]} IS NULL THEN #{convert_null_value} ELSE #{meta_sort_title_array[0]} END #{meta_sort_array[1]}").order("CASE WHEN #{meta_sort_title_array[1]} IS NULL THEN #{convert_null_value} ELSE #{meta_sort_title_array[1]} END #{meta_sort_array[1]}").order(:alternate_family_name, :alternate_given_name).paginate(:page => params[:page])

          #退避させておいた状態を元に戻す
          params[:search]['meta_sort'] = meta_sort
          @search   = Evacuee.mode_in().search(params[:search])
        elsif meta_sort_array[0] == "home_state_and_home_city_and_home_street_and_house_number" then
          convert_null_value = "''"
          meta_sort_title_array = meta_sort_array[0].split("_and_")

          params[:search].delete('meta_sort')
          @search   = Evacuee.mode_in().search(params[:search])
          @evacuees = @search.order("CASE WHEN #{meta_sort_title_array[0]} IS NULL THEN #{convert_null_value} ELSE #{meta_sort_title_array[0]} END #{meta_sort_array[1]}").order("CASE WHEN #{meta_sort_title_array[1]} IS NULL THEN #{convert_null_value} ELSE #{meta_sort_title_array[1]} END #{meta_sort_array[1]}").order("CASE WHEN #{meta_sort_title_array[2]} IS NULL THEN #{convert_null_value} ELSE #{meta_sort_title_array[2]} END #{meta_sort_array[1]}").order("CASE WHEN #{meta_sort_title_array[3]} IS NULL THEN #{convert_null_value} ELSE #{meta_sort_title_array[3]} END #{meta_sort_array[1]}").order(:alternate_family_name, :alternate_given_name).paginate(:page => params[:page])

          #退避させておいた状態を元に戻す
          params[:search]['meta_sort'] = meta_sort
          @search   = Evacuee.mode_in().search(params[:search])
        else
          @search   = Evacuee.mode_in().search(params[:search])
          @evacuees = @search.order(:alternate_family_name, :alternate_given_name).paginate(:page => params[:page])
        end

    else
        @search   = Evacuee.mode_in().search(params[:search])
        @evacuees = @search.order(:alternate_family_name, :alternate_given_name).paginate(:page => params[:page])
    end

    render :action => :index
  end

  # 避難者一覧画面
  # 検索処理
  # 押下されたボタンにより、処理を分岐する
  # * 検索ボタンが押下された場合、検索を行い自画面に遷移する
  # * PFから取込ボタンが押下された場合、PFから避難者情報を取り込む
  # * PFへ出力ボタンが押下された場合、PFへ避難者情報を出力する
  # * 避難者名簿印刷ボタンが押下された場合、検索を行い避難所単位に避難者情報をPDF出力する
  # * 避難所一覧に出力ボタンが押下された場合、避難者情報を集計しLGDISへ出力する
  # * その他の場合、例外を発生させる
  # ==== Args
  # _commit_kind_ :: ボタン種別
  # ==== Return
  # ==== Raise
  def search
    case params[:commit_kind]
    when "search" # 検索ボタン
      index
    when "pf_import" # PFから取込ボタン
      pf_import
    when "pf_export" # PFへ出力ボタン
      pf_export
    when "print" # 避難者名簿印刷ボタン
      print
    when "total" # 避難所一覧に出力ボタン
      total
    else # その他
      index
    end
  end

  # 避難者一覧画面
  # PF避難者情報取込処理
  # ==== Args
  # ==== Return
  # ==== Raise
  def pf_import
    # 非同期でインポート処理を実行する
    flash.now[:notice] = t("notice_successful_pf_import") 
    Resque.enqueue(PfImportJob)
    index
  end

  # 避難者一覧画面
  # PF避難者情報出力処理
  # ==== Args
  # ==== Return
  # ==== Raise
  def pf_export
    flash.now[:notice] = t("notice_successful_pf_export")
    Evacuee.exec_pf_export(Evacuee.mode_in(), current_user)

  rescue ActiveResource::ServerError => e
    flash.now[:alert] = "#{e}"
  rescue Errno::ECONNREFUSED
    flash.now[:alert] = t("errors.messages.connection_refused")
  ensure
    index
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
    require 'nkf'
    # 外部へ公開に同意している避難者のみ出力する
    @search   = Evacuee.mode_in().where(:public_flag => Evacuee::PUBLIC_FLAG_ON).search(params[:search])
    @evacuees = @search.paginate(:page => params[:page])
    # 避難者情報が存在しない場合、出力しない
    if @evacuees.blank?
      flash.now[:alert] = t("errors.messages.evacuees_not_exists")
      render :action => :index
      return
    end
    # 避難者を避難所単位に分ける
    evacuees_list = {}
    @search.each do |evacuee|
      shelter = LocalShelter.hash_for_table[evacuee.shelter_name]
      shelter_name = (shelter.blank? ? "避難所なし" : shelter)
      evacuees_list[shelter_name] = {} unless evacuees_list[shelter_name]
      evacuees_list[shelter_name][evacuee.id] = evacuee
    end
    # 避難所単位でpdfを生成する
    reports = {}
    evacuees_list.each_pair do |shelter_name, evacuees_hash|
      report = ThinReports::Report.new layout: File.join(Rails.root, 'lib', 'evacuees_list.tlf')
      # ヘッダー部の設定
      report.list(:evacuees_list).header do |h|
        h.item(:shelter_name).value(shelter_name)
      end
      # 明細部の設定
      evacuees_hash.each_pair do |id, evacuee|
        report.list(:evacuees_list).add_row do |row|
          row.values name:               "#{evacuee.family_name} #{evacuee.given_name}",
                     name_kana:          "#{evacuee.alternate_family_name} #{evacuee.alternate_given_name}",
                     address:            "#{@state[evacuee.home_state]}#{evacuee.home_city}#{evacuee.home_street}#{evacuee.house_number}",
                     date_of_birth:      (evacuee.date_of_birth.present? ? evacuee.date_of_birth.strftime("%Y/%m/%d") : ""),
                     age:                evacuee.age,
                     shelter_entry_date: (evacuee.shelter_entry_date.present? ? evacuee.shelter_entry_date.strftime("%Y/%m/%d") : ""),
                     shelter_leave_date: (evacuee.shelter_leave_date.present? ? evacuee.shelter_leave_date.strftime("%Y/%m/%d") : ""),
                     next_place:         evacuee.next_place
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
    # IEでのファイルダウンロードの際の文字化け対策
    ie_download_name = "避難者一覧"
    ie_download_name = ERB::Util.url_encode(ie_download_name) if /MSIE/ =~ request.user_agent
    # zipを出力する
    send_data(buf, filename: ie_download_name + "_#{Time.now.instance_eval {'%s%06d' % [strftime('%Y%m%d%H%M%S'),usec]}}.zip",
      type: "application/zip", disposition: "attached")
  end

  # 避難者一覧画面
  # 集計処理
  # 避難者情報を集計しLGDISに連携する
  # ==== Args
  # ==== Return
  # ==== Raise
  def total
    cache = {}
    # ルーティング上プロジェクト識別子が必要
    project_identifier = SETTINGS["activeresource"]["lgdis"]["project_identifier"]
    shelters = Shelter.find(:all, :params => { project_id: project_identifier })

    summary = Hash.new
    Evacuee.mode_in().find_for_count.each do |result|
      summary[result.shelter_name] = result
      # 避難所識別番号が一致する避難所を取得
      #index = shelters.rindex{|s| 
      #  p s.shelter_code
      #  s.shelter_code == result.shelter_name 
      #}
      #next if index.blank?
      #shelter = shelters[index]
      # 人数（自主避難人数を含む）
      #shelter.head_count = result["head_count"]
      # 世帯数（自主避難世帯数を含む）
      # shelter.households = result["households_count"]
      # 負傷_計
      #shelter.injury_count = result["injury_flag_count"]
      # 要介護度_計
      #shelter.upper_care_level_three_count = result["upper_care_level_three_count"]
      # 一人暮らし高齢者（65歳以上）_計
      #shelter.elderly_alone_count = result["elderly_alone_count"]
      # 高齢者世帯（夫婦共に65歳以上）_計
      #shelter.elderly_couple_count = result["elderly_couple_count"]
      # 寝たきり高齢者_計
      #shelter.bedridden_elderly_count = result["bedridden_elderly_count"]
      # 認知症高齢者_計
      #shelter.elderly_dementia_count = result["elderly_dementia_count"]
      # 療育手帳所持者_計
      #shelter.rehabilitation_certificate_count = result["rehabilitation_certificate_count"]
      # 身体障害者手帳所持者_計
      #shelter.physical_disability_certificate_count = result["physical_disability_certificate_count"]
      # 不要データを削除
      #shelter.attributes.delete(:created_at)
      #shelter.attributes.delete(:updated_at)
      #shelter.attributes.delete(:deleted_at)
      #shelter.attributes.delete(:record_mode)

      #shelter.save
    end

    shelters.each do |shelter|
      if summary.include?(shelter.shelter_code)
        result = summary[shelter.shelter_code]
        # 人数（自主避難人数を含む）
        shelter.head_count = result["head_count"]
        # 世帯数（自主避難世帯数を含む）
        shelter.households = result["households_count"]
        # 負傷_計
        shelter.injury_count = result["injury_flag_count"]
        # 要介護度_計
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
      else
        result = summary[shelter.shelter_code]
        # 人数（自主避難人数を含む）
        shelter.head_count = 0
        # 世帯数（自主避難世帯数を含む）
        shelter.households = 0
        # 負傷_計
        shelter.injury_count = 0
        # 要介護度_計
        shelter.upper_care_level_three_count = 0
        # 一人暮らし高齢者（65歳以上）_計
        shelter.elderly_alone_count = 0
        # 高齢者世帯（夫婦共に65歳以上）_計
        shelter.elderly_couple_count = 0
        # 寝たきり高齢者_計
        shelter.bedridden_elderly_count = 0
        # 認知症高齢者_計
        shelter.elderly_dementia_count = 0
        # 療育手帳所持者_計
        shelter.rehabilitation_certificate_count = 0
        # 身体障害者手帳所持者_計
        shelter.physical_disability_certificate_count = 0
      end

      # 不要データを削除
      shelter.attributes.delete(:created_at)
      shelter.attributes.delete(:updated_at)
      shelter.attributes.delete(:deleted_at)
      shelter.attributes.delete(:record_mode)

      shelter.save
    end

    flash.now[:notice] = t("notice_successful_total")
  rescue ParameterException
    flash.now[:alert] = t("errors.messages.projects_not_exists")
  rescue ActiveResource::ServerError, ActiveResource::UnauthorizedAccess => e
    flash.now[:alert] = "#{e}"
  rescue Errno::ECONNREFUSED
    flash.now[:alert] = t("errors.messages.connection_refused")
  ensure
    index
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
          flash[:notice] = t("notice_successful_create")
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
    @evacuee = Evacuee.mode_in().find(params[:id])
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
      @evacuee = Evacuee.mode_in().find(params[:id])
      if @evacuee.update_attributes(params[:evacuee])
        flash[:notice] = t("notice_successful_update")
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
  # * 戻るボタンが押下された場合、避難者一覧画面に遷移する
  # * その他の場合、例外を発生させる
  # ==== Args
  # _commit_kind_ :: ボタン種別
  # _id_ :: 避難者ID
  # ==== Return
  # ==== Raise
  def selector
    case params[:commit_kind]
    when "delete"
      @evacuee = Evacuee.mode_in().find(params[:id])
      @evacuee.destroy
      flash[:notice] = t("notice_successful_delete")
      redirect_to :action => :index
    when "back"
      redirect_to :action => :index
    else
      raise
    end
  end
end
