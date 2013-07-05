require 'yaml'
class FeaturesController < ApplicationController
  # GET /features
  # GET /features.json

  def index
    @features = Feature.order(:name).page(params[:page]).per(5)
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
    all_features= Dir.glob "**/*.feature"
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
  def execute
      @feature = Feature.find(params[:id])           #make session for save and other.
      session[:executed_feature]||= Feature.new
      session[:executed_feature] = @feature
      `bundle exec cucumber --color -r features ./#{@feature.name} -f html > ./app/views/features/execute.html.erb`
      render(layout: 'layouts/save_layout')       #to use the save layout in order not to ruin the application layout
  end

  def report
    @feature = Feature.find(params[:id])
    `bundle exec cucumber --color -r features ./#{@feature.name} -f html > ./app/views/features/execute.html.erb`
     send_file "./app/views/features/execute.html.erb",:filename=> "report_#{@feature.name.gsub(/\//,"_")}.html",:disposition => "attachment"
  end
  def save
    @feature = session[:executed_feature]
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

def execute2
  begin
  @checked_ip = params[:checked_ips].delete_if{|x| x==" "}    #check the array of checked ip out
  hash_ip= Hash.new
  hash_ip_add = Hash.new
 @checked_ip.each_with_index do |x,index|
      hash_ip[index]=x
   end    #revert the arry to hash
  hash_ip_add.store('checked_ips',hash_ip)
  @root = Pathname.new(File.dirname(__FILE__)).parent.parent.realpath.to_s
  File.open("#{@root}/lib/resource/execute_ip.yml", 'w') { |f| YAML.dump(hash_ip_add, f) }  # 写入文件
  @is_remote = YAML.load_file("#{@root}/lib/resource/execute_ip.yml")
  @is_remote['checked_ips'].each do |key,value|
 `bundle exec cucumber --color -r features ./#{session[:executed_feature].name} -f html > ./app/views/features/_execute#{key}.html.erb`
  end
  @is_remote_size = @is_remote['checked_ips'].size
 rescue
    nil
  ensure
  File.delete "#{@root}/lib/resource/execute_ip.yml"
  render(layout: 'layouts/save_layout2')
  end
end



end
