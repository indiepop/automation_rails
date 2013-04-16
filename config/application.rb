require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module AutomationRails
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable
    #自动读取目录（库）
    #如果 app/models 下的檔案太多，我們可以很簡單地增加新的子目錄來做分類，例如
    #我們可以將檔案直接搬到 app/models/foobar 子目錄下(程式內容無需修改)，然後將這個目錄加進 autoload_paths 即可，
    #例如 config.autoload_paths += %W( #{config.root}/app/lib #{config.root}/app/models/foobar)。
    #這裡的 %W 是 Ruby 的陣列簡寫用法。
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # 設定預設的應用程序時區，預設是 UTC。
    # 在 Rails 中，数据庫裡面儲存的時間皆為 UTC 時間，而設定此時區會自動幫你處理轉換動作。
    # 例如設定 Beijing 的話，從資料庫讀取出來時會自動加八小時，存進資料庫時會自動減八小時。
    #rake time:zones:all[D]
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # 这个是设置应用程序语系的
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    # 避免参数为password到数值被记录到 log中去
    config.filter_parameters += [:password]

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    #每次跑測試的時候，為了節省建立資料庫的時間，預設的 schema_format = :ruby 會使用 schema.rb
    # 而不是跑 Migrations。不過，schema.rb 沒辦法表達出特定資料庫所專屬的功能，
    # 像是外部鍵約束（foreign key constraints）、觸發（triggers）或是預存程序（stored procedures）。
    # 所以如果你的 Migration 中有自定的 SQL 陳述句，請在這裡把 schema 的格式設定成 :sql。
    # config.active_record.schema_format = :sql

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    # 白名单设置
    config.active_record.whitelist_attributes = false

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
  end
end
