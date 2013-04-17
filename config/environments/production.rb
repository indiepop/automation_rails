AutomationRails::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  #cache_classes = true 表示在 production 中，類別檔案載入進記憶體中就快取起來了，大大獲得效能。
  # 不像在 development 環境中每一次 HTTP 請求就會重新載入一次。
  # Code is not reloaded between requests
  config.cache_classes = true

  #不同於 development，如果在 production 環境出現例外錯誤，不會顯示程式 call stack 訊息，而是回傳 public/500.html 頁面。
  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  #不像 development 和 test，在這裡我們會讓 Rails 應用伺服器關掉對靜態檔案的回應。
  # 在 production 環境中，靜態檔案應該由效能極佳的 Apache 或 Nginx 網頁伺服器直接提供檔案。我們會在部署一章詳細介紹伺服器的架構。

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = false

  #TODO:Assets

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false

  # Generate digests for assets URLs
  config.assets.digest = true

  # Defaults to Rails.root.join("public/assets")
  # config.assets.manifest = YOUR_PATH

  #“X-Sendfile” 是網頁伺服器提供的功能，可以讓下載檔案的動作完全委派給網頁伺服器，Rails 送出 X-Sendfile 標頭後就毋需再佔住資源。

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  #是否限制全站必須SSL才能使用。
  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true


  #我們在 RESTful 應用程式 一章最後介紹了 Logger。這裡可以設定 Logger 的層級。預設 production 是 :info，其他則是 :debug
  # See everything in the log (default is :info.yml)
  # config.log_level = :debug

  # Prepend all log lines with the following tags
  # config.log_tags = [ :subdomain, :uuid ]

  #可以更換掉 Rails 內建的 Logger，例如換成使用 syslog 的 SyslogLogger。
  # Use a different logger for distributed setups
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  #設定不同的快取儲存庫，預設是 :memory_store，也就是每個 Rails process 各自用記憶體存放。
  # 業界最常用的則是 memcached 記憶體快取伺服器。
  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  #預設的靜態檔案位置是目前主機的 public 目錄，你可以透過修改 asset_host 變更位置。
  # 例如你的靜態檔案放在不同台機器或 CDN(Content delivery network) 上。
  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # TODO: Assets
  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  # config.assets.precompile += %w( search.js )

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  #雖然 Rails 支援 thread-safe 模式，不過這裡預設是關閉的。
  # Ruby 1.8 的 thread 由於不是作業系統層級的 thread，並不會真的使用到多顆 CPU，
  # Ruby 1.9 雖然是，但是因為某些內建函式庫不 thread-safe，所以多 thread 實際上也是跑在同一顆 CPU。
  # 因此，啟用 threaded 模式獲得的效能改善有限，但是設定上卻麻煩的多，例如你無法使用 Rails 的自動載入類別功能。
  # 你也無法在 development 環境中打開。實務上我們會在伺服器上執行多個 Rails process，因此不需要也不建議打開 threaded 模式

  # Enable threaded mode
  # config.threadsafe!

  #如果 I18n 翻譯檔找不到，則找用預設語系的文字。ToDo:i18n
  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  #將 deprecation 訊息傳到 Notifications 頻道，你可以用以下程式去訂閱這個訊息：
  # ActiveSupport::Notifications.subscribe("deprecation.rails") do |message, callstack|
  # deprecation message
  #end
  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  # config.active_record.auto_explain_threshold_in_seconds = 0.5
end
