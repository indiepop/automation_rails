AutomationRails::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development

  # cache_classes = false 會讓每一次的 HTTP 請求都重新載入類別檔案。更仔細的說，當這個值是 false 的時候，
  # Rails 會改用 Ruby 的 load 方法，每次執行都會重新載入一次。
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  #當你對 nil 呼叫方法時，會出現 NoMethodError。whiny_nils = true 會提示你更多訊息來除錯。這個值在 production 預設是 false。
  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  #Rails只有在連線是來自本地端的時候，才會將發生錯誤時的Call stack trace資訊給瀏覽器顯示。
  # 這個設定將所有連線都當做本地端連線，好讓開發模式時所有人連線都可以看到錯誤訊息。
  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  #是否啟用 Controller 層級的快取(我們會在 Controller 一章介紹到有哪些快取方法)，一般來說在開發模式不會啟用，除非你要測試它。
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  #如果email失敗，是否要丟出异常。建議可以改成 true。
  config.action_mailer.raise_delivery_errors = false

  #隨著 Rails 版本的升級，如果有方法會在之後的版本中移除，deprecation 會提示你如何因應。這裡的 :log 表示會記錄到 log 檔案中
  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  #Rails會在HTTP Header中加上X-UA-Compatible屬性，這個屬性可以用來告訴IE瀏覽器去支援最新網頁標準，而不是相容模式。
  # 在這裡開發模式中這裡設成:builtin的意思是IE=edge，
  # 而在production模式中預設是true，意思是IE=edge,chrome=1，多啟用了Chrome Frame，如果使用者有裝Chrome Frame，
  # 就可以讓舊版IE瀏覽器使用Chrome的WebKit引擎來處理網頁，讓舊版IE也可以使用到現代網頁技術。
  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  #當SQL查詢超過0.5秒時，自動做SQL explain在Log裡
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true
end
