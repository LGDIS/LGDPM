class CustomObserver < ActiveRecord::Observer
  observe Evacuee, Juki, JukiHistory, User
  
  def after_save(rec)
    
  end
end
