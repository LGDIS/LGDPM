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
    # 承認チェックしたLocalPersonID
    # params[:approval_local_people]
    if params[:approval_local_people].present?
      ActiveRecord::Base.transaction do
        lp_ids = params[:approval_local_people].split(",")
        lp_ids.each do |id|
          local_person = LocalPerson.find(id)
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
    redirect_to :action => :index
  end
end
