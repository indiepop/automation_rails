class ApplicationController < ActionController::Base
  protect_from_forgery
  #  啟動了CSRF安全性功能，所有非GET的HTTP request都必須帶有一個Token參數才能存取，Rails會自動在所有表單中幫你插入Token參數，預設的Layout中也有一行<%= csrf_meta_tag %>標籤可以讓JavaScript讀取到這個Token。
  #  取消：skip_before_filter :verify_authenticity_token
end
