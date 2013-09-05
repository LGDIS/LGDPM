# -*- coding:utf-8 -*-
class PfImportJob
  @queue = :pf_import

  # PF避難者情報取込非同期処理
  # ==== Args
  # ==== Return
  # ==== Raise
  def self.perform
    @people = Person.find_for_import
    return if @people.blank?
    
    @people.each do |person|
      evacuee = Evacuee.new
      evacuee = evacuee.exec_insert(person)
      begin
        evacuee.save
        person.update_attributes(:link_flag => true)
      rescue => e
        Rails.logger.info(e.message)
        Rails.logger.info(person.id)
      end
    end
  end
end
