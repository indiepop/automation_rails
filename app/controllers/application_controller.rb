class ApplicationController < ActionController::Base
  protect_from_forgery
  #  啟動了CSRF安全性功能，所有非GET的HTTP request都必須帶有一個Token參數才能存取，Rails會自動在所有表單中幫你插入Token參數，預設的Layout中也有一行<%= csrf_meta_tag %>標籤可以讓JavaScript讀取到這個Token。
  #  取消：skip_before_filter :verify_authenticity_token
end


#action_name 目前的Action名稱
#cookies Cookie 下述
#headers HTTP標頭
#params 包含用戶所有傳進來的參數Hash，這是最常使用的資訊

#request 各種關於此request的詳細資訊
#request_method
#method
#delete?, get?, head?, post?, put?
#xml_http_request? 或 xhr?
#url
#protocol, host, port, path 和 query_string
#domain
#host_with_port
#port_string
#ssl?
#remote_ip?
#path_without_extension, path_without_format_and_extension, format_and_extension, relative_path
#env
#accepts
#format
#mime_type
#content_type
#headers
#body
#content_length

#response 代表要回傳的內容，會由Rails設定好。通常你會用到的時機是你想加特別的Response Header


#-----------------------------------------------

#Render
=begin
直接回傳結果

render :text => "Hello" 直接回傳字串內容，不使用任何樣板。
render :xml => @event.to_xml 回傳XML格式
render :json => @event.to_json 回傳JSON格式(再加上:callback就會是JSONP)
render :nothing => true 空空如也

指定Template

:template 指定Template
:action 指定使用該Action的Template(注意到只是使用它的Template，而不會執行該Action內的程式)
:file 指定Template的檔名全名

其他參數

:status 設定HTTP status，預設是200，也就是正常。其他常用代碼包括401權限不足、404找不到頁面、500伺服器錯誤等。
:layout 可以指定這個Action的Layout，設成false即關掉Layout


Filters

可將Controller中重複的程式抽出來，有三種方法可以定義在進入Action之前、之中或之後執行特定方法，分別是before_filter、after_filter和around_filter，其中before_filter最為常用。這三個方法可以接受Code block、一個Symbol方法名稱或是一個物件(Rails會呼叫此物件的filter方法)。
before_filter

before_filter最常用於準備跨Action共用的資料，或是使用者權限驗證等等：

class EventsControler < ApplicationController
  before_filter :find_event, :only => :show

  def show
  end

  protected

  def find_event
    @event = Event.find(params[:id])
  end

end

每一個都可以搭配:only或:except參數。
around_filter

# app/controllers/benchmark_filter.rb
class BenchmarkFilter
    def self.filter(controller)
     timer = Time.now
     Rails.logger.debug "---#{controller.controller_name} #{controller.action_name}"
     yield # 這裡讓出來執行Action動作
     elapsed_time = Time.now - timer
     Rails.logger.debug "---#{controller.controller_name} #{controller.action_name} finished in %0.2f" % elapsed_time
    end
end

# app/controller/events_controller.rb
class EventsControler < ApplicationController
    around_filter BenchmarkFilter
end

Filter的順序

當有多個Filter時，Rails是由上往下依序執行的。如果需要加到第一個執行，可以使用prepend_before_filter方法，同理也有prepend_after_filter和prepend_around_filter。

如果需要取消從父類別繼承過來的Filter，可以使用skip_before_filter :filter_method_name方法，同理也有skip_after_filter和skip_around_filter。
rescue_from

rescue_from可以在Controller中宣告救回例外，例如：

class ApplicationController < ActionController::Base

    rescue_from ActiveRecord::RecordNotFound, :with => :show_not_found
    rescue_from ActiveRecord::RecordInvalid, :with => :show_error

    protected

    def show_not_found
        # render something
    end

    def show_error
        # render something
    end

end

HTTP Basic Authenticate

Rails內建支援HTTP Basic Authenticate，可以很簡單實作出認證功能：

class PostsController < ApplicationController
    before_filter :authenticate

    protected

    def authenticate
     authenticate_or_request_with_http_basic do |username, password|
       username == "foo" && password == "bar"
     end
    end
end

在Rails 3.1後，也可以這樣寫：

class PostsController < ApplicationController
    http_basic_authenticate_with :name => "foo", :password => "bar"
end
=end

