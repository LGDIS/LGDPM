# -*- coding:utf-8 -*-
class LocalPeopleController < ApplicationController
  # タブリンクのカレントタブ制御に使用
  set_tab :local_person
  
  # 石巻PF避難者承認画面
  # 初期表示処理
  # ==== Args
  # ==== Return
  # ==== Raise
  def index
    @search = LocalPerson.search(:id_eq => 0) # 取得件数0件で初期表示させるため
    @local_people = @search.paginate(:page => params[:page], :per_page => 30)
  end
  
  # 石巻PF避難者承認画面
  # 検索処理
  # ==== Args
  # ==== Return
  # ==== Raise
  def search
    case params[:commit_kind]
    when "search"
      @search = LocalPerson.search(params[:search])
      @local_people = @search.paginate(:page => params[:page], :per_page => 30).order("alternate_names ASC")
      render :action => :index
    when "approval"
      approval
    when "import"
      import
    else
      raise
    end
  end
  
  # 石巻PF避難者承認画面
  # 承認処理
  # ==== Args
  # ==== Return
  # ==== Raise
  def approval
    # TODO 承認済みの場合、再承認したときの動きを検討する
    # 承認チェックしたLocalPersonID
    # params[:approval_local_people]
    if params[:approval_local_people].present?
      ActiveRecord::Base.transaction do
        lp_ids = params[:approval_local_people].split(",")
        lp_ids.each do |id|
          local_person = LocalPerson.find(id)
          next if local_person.approved_by.present? && local_person.approved_at.present?
          evacuee = Evacuee.new
          evacuee = evacuee.exec_insert(local_person)
          evacuee.save!
          local_person.approved_by = current_user.login
          local_person.approved_at = Time.now
          local_person.save!
        end
      end
    end
    @search = LocalPerson.search(params[:search])
    @local_people = @search.paginate(:page => params[:page], :per_page => 30).order("alternate_names ASC")
    render :action => :index
  end
  
  # 石巻PF避難者承認画面
  # LocalPersonFinder取込処理
  # ==== Args
  # ==== Return
  # ==== Raise
  def import
    # TODO ARで更新した場合にtransactionがどうなるのか検証する
    # TODO person取込済みかつ新しいnoteが存在する場合どうするか検討する
    # TODO person取込済みかつ期限延長されている場合どうするか検討する
    # TODO 重複登録されている場合どうするか検討する
    # TODO 期限切れの場合どうするか検討する
    # TODO 論理削除された場合どうするか検討する
    # TODO 例外処理
    ActiveRecord::Base.transaction do
      @people = Person.find_for_import
      @people.each do |person|
        local_person = LocalPerson.new
        local_person = local_person.exec_insert(person)
        note = Note.find_for_import(person)
        local_person.status = note.status
        local_person.last_known_location = note.last_known_location
        local_person.save!
        
        person.update_attributes(:link_flag => true)
        note.update_attributes(:link_flag => true) unless note.id.blank?
      end
    end
    @search = LocalPerson.search(params[:search])
    @local_people = @search.paginate(:page => params[:page], :per_page => 30).order("alternate_names ASC")
    render :action => :index
  end
end