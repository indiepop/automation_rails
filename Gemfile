source 'https://rubygems.org'
#第二个参数可以指定版本
gem 'rails', '3.2.2'

# Bundle edge Rails instead:    可以用 Git 當做來源(根目錄要有 .gemspec 檔案)，甚至可以指定 branch, tag 或 ref。
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# 不指定版本则会使用最新版
gem 'mysql2'


# Gems used only for assets and not required
# in production environments by default.
# Group 功能可以讓特定環境才會載入
group :assets do

#”~> x.y.z” 的意思是版號 x,y 固定，但可以大於等於 z。
  gem 'sass-rails',   '~> 3.2.3'
#  gem 'sass-rails',   '3.2.5'
  gem 'coffee-rails', '~> 3.2.1'
# gem 'coffee-rails', '3.2.2'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
 # gem 'uglifier', '1.2.4'
end

gem 'jquery-rails'
# gem 'jquery-rails' ,'2.0.2'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'


group :cucumber do
  gem 'capybara'
#  gem 'capybara','1.1.2'
  gem 'database_cleaner'
#  gem 'database_cleaner' ,'0.7.2'
  gem 'cucumber-rails'
#  gem 'cucumber-rails','1.3.0'
  gem 'cucumber'
# gem 'cucumber','1.2.0'
  gem 'rspec-rails', '>= 2.0.0.beta.10'
# gem 'rspec-rails','2.10.1'
  gem 'spork'
# gem 'spork','0.9.2'
  gem 'launchy'    # So you can do Then show me the page
# gem 'launchy','2.1.0'
  gem 'factory_girl'
# gem 'factory_girl','3.4.2'
end

#PAGE
gem 'kaminari'

#bundle update gem_name 則會更新此 gem 的版本
#bundle update 則會檢查所有的 gem 更新到最新版本。
#一般來說你只需要在每次 Gemfile 修改後，執行 bundle install 即可。
# 如果有套件關連性 bundle install 無法解決，它會提示你執行 bundle update。

#一般來說，總是執行 bundle install 即可。這個指令只會做必要的更新到 Gemfile.lock，執行速度較快，它不會幫你升級現有的 Gem。
# 而 bundle update 會重新產生整個 Gemfile.lock 檔案，更新所有 Gem 到最新版本。
# 但是，一次升級太多套件，可能會造成除錯上的困難。因此會建議如果要升級，請執行 bundle update gem_name 一次升級一個套件。

#bundle outdated  列出有新版本可以升級的gems

#打包 Gems

#執行以下指令，會將所有用到的 Gems 打包進 vendor/cache 目錄。如此執行 bundle install 時就不會連線到 http://rubygems.org 下載套件。

#bundle package
#如果你有非 Rails 的 script 需要執行
# (也就是放在 Gemfile 檔案中的 Gem 所自行提供的執行檔)，使用 bundle exec 可以正確的載入 Bundler 的環境。
# 例如 bundle exec rspec spec/
