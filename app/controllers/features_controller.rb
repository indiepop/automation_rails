class FeaturesController < ApplicationController
  # GET /features
  # GET /features.json
 $appear=false
 before_filter :appear_sub,:only => [:execute]
 after_filter :disappear_sub ,:only => [:index]

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
      @feature = Feature.find(params[:id])
      $executed_feature = @feature
      `bundle exec cucumber --color -r features ./#{@feature.name} -f html > ./app/views/features/_execute.html.erb`
      redirect_to features_path

  end
  def report
    @feature = Feature.find(params[:id])
    `bundle exec cucumber --color -r features ./#{@feature.name} -f html > ./app/views/features/_execute.html.erb`
     send_file "./app/views/features/_execute.html.erb",:filename=> "report_#{@feature.name.gsub(/\//,"_")}.html",:disposition => "attachment"
  end
  def save
    @feature = $executed_feature
    send_file "./app/views/features/_execute.html.erb",:filename=> "report_#{@feature.name.gsub(/\//,"_")}.html",:disposition => "attachment"

  end
 def search
    @features = Feature.where(["name like ?","%#{params[:keyword]}%"]).order(:name).page(params[:page]).per(5)
    render :action => :index

 end
private
  def appear_sub
    $appear= true
  end
  def disappear_sub
    $appear= false
  end

end
