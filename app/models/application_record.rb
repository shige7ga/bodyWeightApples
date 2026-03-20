class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # 定数：りんごの重さ300g/個 あとでデータベース化する予定
  APPLE_WEIGHT = 300
end
