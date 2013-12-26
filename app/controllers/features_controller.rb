require 'yaml'
class FeaturesController < ApplicationController
  # GET /features
  # GET /features.json

  def index
    @features = Feature.order(:name).page(params[:page]).per(5)    #配置kaminari到参数，每页几个数据
    @tags = Tag.all
    respond_to do |format|
      format.html # No_index.html.erb
      format.json { render json: @features }
    end

  end

  # GET /features/1
  # GET /features/1.json
  def show
    @feature = Feature.find(params[:id])
   # @content = File.readlines(@feature.name).each {|line| line.rstrip!<<'<br/>'}
    @content= File.read(@feature.name)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @feature }
    end
  end

  # GET /features/new
  # GET /features/new.json
  def new
    @tags = Tag.all
    @feature = Feature.new
    all_features= Dir.glob "**/*.feature"       #递归获取所有目录
    db_features = Array.new
    Feature.find_each{|t| db_features<<t.name}          #get the to the array from db with names
        @feature_name= all_features - db_features
    @feature_name.empty?  ? @prompt= "Sorry ,there is no feature need to be created ..."  :  @prompt= "Please select a Feature ..."        # 判断是否有需要添加的feature

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @feature }
    end
  end

  # GET /features/1/edit
  def edit
    @tags = Tag.all
    @feature = Feature.find(params[:id])
    @edit_told= [Feature.find(params[:id]).name]
  end

  # POST /features
  # POST /features.json
  def create
    @feature = Feature.new(params[:feature])
        respond_to do |format|
      if @feature.save
        format.html { redirect_to @feature, notice: 'Feature was successfully created.' }
        format.json { render json: @feature, status: :created, location: @feature }
      else
        format.html { render action: "new" }
        format.json { render json: @feature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /features/1
  # PUT /features/1.json
  def update
    @feature = Feature.find(params[:id])
    @tags = Tag.all
    respond_to do |format|
      if @feature.update_attributes(params[:feature])
        format.html { redirect_to @feature, notice: 'Feature was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @feature.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /features/1
  # DELETE /features/1.json
  def destroy
    @feature = Feature.find(params[:id])
    @feature.destroy
    respond_to do |format|
      format.html { redirect_to features_url }
      format.json { head :no_content }
    end
  end

  def execute                                        #执行
      @feature = Feature.find(params[:id])           #获取要执行脚本到ID
      session[:executed_feature]||= Feature.new      #为今后生成报告，产生Session
      session[:executed_feature] = @feature
      `bundle exec cucumber --color -r features ./#{@feature.name} -f html > ./app/views/features/execute.html.erb` #执行cucumber指令，并打开同名erb
      render(layout: 'layouts/save_layout')         #因为产生到报告是独有的，嵌套在另一个样式到layout里面
  end

  def report                                        #执行并下载
    @feature = Feature.find(params[:id])            #获取要执行脚本到ID
    `bundle exec cucumber --color -r features ./#{@feature.name} -f html > ./app/views/features/execute.html.erb`
     send_file "./app/views/features/execute.html.erb",:filename=> "report_#{@feature.name.gsub(/\//,"_")}.html",:disposition => "attachment"
  end

  def save
    @feature = session[:executed_feature]            #获取从执行过程得到到session，然后下载
    send_file "./app/views/features/execute.html.erb",:filename=> "report_#{@feature.name.gsub(/\//,"_")}.html",:disposition => "attachment"
  end

  def search
    @features = Feature.where(["name like ?","%#{params[:keyword]}%"]).order(:name).page(params[:page]).per(5)
    render :action => :index
  end

 def machine
     @feature=Feature.find(params[:id])
     @feature_name=@feature.name
     @machines=Machine.all
     session[:executed_feature]||= Feature.new
     session[:executed_feature]= @feature    #the feature that need to run
 end

def remote_execute
  begin
    @checked_ip = params[:checked_ip]
    hash_ip = {:checked_ip=>@checked_ip}
    @root = Pathname.new(File.dirname(__FILE__)).parent.parent.realpath.to_s
    File.open("#{@root}/lib/resource/execute_ip.yml", 'w') { |f| YAML.dump(hash_ip, f) }
    @is_remote = YAML.load_file("#{@root}/lib/resource/execute_ip.yml")   #{:checked_ip="45645641"}

    `bundle exec cucumber --color -r features ./#{session[:executed_feature].name} -f html > ./app/views/features/remote_execute.html.erb`
  rescue
    puts "something happens."
  ensure
    File.delete "#{@root}/lib/resource/execute_ip.yml"         #毁灭罪证
    render(layout: 'layouts/save_layout')    #use the special layout
  end
end

def multiple_execute         #because this procedure need run with system command , we need to use a file system to communicate
  begin
    @checked_ip = params[:checked_ips].delete_if{|x| x==" "}    #获取一个数组保存被选取到的IPs
    hash_ip= Hash.new
    hash_ip_add_title = Hash.new
    @checked_ip.each_with_index do |x,index|   #switch the arry to hash ，得到hash_ip{1=>ip1,2=>ip2}这种形式
     hash_ip[index]=x
    end
    hash_ip_add_title.store('checked_ips',hash_ip)   #形成{'checked_ip'=>{1=>ip1,2=>ip2}}
    @root = Pathname.new(File.dirname(__FILE__)).parent.parent.realpath.to_s
    File.open("#{@root}/lib/resource/execute_ip.yml", 'w') { |f| YAML.dump(hash_ip_add_title, f) }  # 写入文件
    @is_remote = YAML.load_file("#{@root}/lib/resource/execute_ip.yml")
#    File.open("./app/views/features/_execute.html.erb","w") do
#      |file| file.puts " "
#    end
    `bundle exec cucumber --color -r features ./#{session[:executed_feature].name} -f html > ./app/views/features/_execute.html.erb`
     #There is a bug, the report is only one.
  rescue
      puts "something happens."
  ensure
      File.delete "#{@root}/lib/resource/execute_ip.yml"         #毁灭罪证
      render(layout: 'layouts/save_layout')    #use the special layout
  end
end

end
