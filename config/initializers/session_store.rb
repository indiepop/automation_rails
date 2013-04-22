# Be sure to restart your server when you modify this file.

AutomationRails::Application.config.session_store :cookie_store, key: '_automation_rails_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# AutomationRails::Application.config.session_store :active_record_store

=begin
Sessions

HTTP是一種無狀態的通訊協定，為了能夠讓瀏覽器能夠在跨request之間記住資訊，Rails提供了Session功能，像是記住登入的狀態、記住使用者購物車的內容等等，都是用Session實作出來的。

要操作Session，直接操作session這個Hash變數即可。例如：

session[:cart] = Cart.new

只要是可以被序列化的物件，都可以放進session之中。當然，你不會想放太大的資料進去，這樣每次request讀取時會降低伺服器的效能。
Session storage

Rails預設採用Cookies session storage來儲存Session資料，它是將Session資料透過config/initializers/secret_token編碼後放到瀏覽器的Cookie之中，最大的好處是對伺服器的效能負擔很低，缺點是大小最多4Kb，以及資料還是可以透過反編碼後看出來，只是無法進行修改。因此安全性較低，不適合存放機密資料。

除了Cookies session storage，Rails也支援其他方式，你可以修改config/initializers/session_store.rb：

    :active_record_store 使用資料庫來儲存。
    :mem_cache_store 使用Memcached快取系統來儲存

一般來說使用預設的Cookies session storage即可，如果對安全性較高要求，可以使用資料庫。如果希望兼顧效能，可以考慮使用Memcached。

採用:active_record_store的話，必須產生sessions資料表：

$ rake db:sessions:create
$ rake db:migrate

Cookies

除了Session，我們也可以直接操作底層的Cookie，以下是一些使用範例：

# Sets a simple session cookie.
cookies[:user_name] = "david"

# Sets a cookie that expires in 1 hour.
cookies[:login] = { :value => "XJ-122", :expires => 1.hour.from_now }

# Example for deleting:
cookies.delete :user_name

cookies[:key] = {
   :value => 'a yummy cookie',
   :expires => 1.year.from_now,
   :domain => 'domain.com'
}

cookies.delete(:key, :domain => 'domain.com')

因為資料是存放在使用者瀏覽器，所以如果需要保護不能讓使用者亂改，Rails也提供了Signed方法：

cookies.signed[:user_preference] = @current_user.preferences

另外，如果是盡可能永遠留在使用者瀏覽器的資料，可以使用Permanent方法：

cookies.permanent[:remember_me] = [current_user.id, current_user.salt]

兩者也可以加在一起用：

cookies.permanent.signed[:remember_me] = [current_user.id, current_user.salt]

Flash訊息

我們在Part1示範過用Flash來傳遞訊息。它的用處在於redirect時，能夠從這一個request傳遞文字訊息到下一個request，例如從create Action傳遞「成功建立」的訊息到show Action。

flash是一個Hash，其中的鍵你可以自定，常用:notice、:warning或:error等。例如我們在第一個Action中設定它：

def create
  @event = Event.create(params[:event])
  flash[:notice] = "成功建立"
  redirect_to :action => :show
end

那麼在下一個Action中，我們就可以在Template中讀取到這個訊息，通常我們會放在Layout中：

<p><%= flash[:notice] %></p>

使用過一次之後，Rails就會自動清除flash。

另外，有時候你等不及到下一個Action，就想讓Template在同一個Action中讀取到flash值，這時候你可以寫成：

flash.now[:notice] = "foobar"
=end
