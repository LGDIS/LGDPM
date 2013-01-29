# -*- coding:utf-8 -*-
class JukiImportJob
  @queue = :juki_import

  # 住基情報取込非同期処理
  # ==== Args
  # _file_ :: 住基CSVファイル
  # _user_ :: 実行ユーザ
  # ==== Return
  # ==== Raise
  def self.perform(file, user)
    Juki.import(file, user)
  end
end
