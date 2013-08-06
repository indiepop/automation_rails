require 'roadrunner/lib/roadrunner'
require 'httparty'
#require 'rfuzz'
class RoadrunnersController < ApplicationController
  # GET /roadrunners
  # GET /roadrunners.json
  def index
    @roadrunners = Roadrunner.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @roadrunners }
    end
  end

  # GET /roadrunners/1
  # GET /roadrunners/1.json
  def show
    @roadrunner = Roadrunner.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @roadrunner }
    end
  end

  # GET /roadrunners/new
  # GET /roadrunners/new.json
  def new
    @roadrunner = Roadrunner.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @roadrunner }
    end
  end

  # GET /roadrunners/1/edit
  def edit
    @roadrunner = Roadrunner.find(params[:id])
  end

  # POST /roadrunners
  # POST /roadrunners.json
  def create
    @roadrunner = Roadrunner.new(params[:roadrunner])

    respond_to do |format|
      if @roadrunner.save
        format.html { redirect_to @roadrunner, notice: 'Roadrunner was successfully created.' }
        format.json { render json: @roadrunner, status: :created, location: @roadrunner }
      else
        format.html { render action: "new" }
        format.json { render json: @roadrunner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /roadrunners/1
  # PUT /roadrunners/1.json
  def update
    @roadrunner = Roadrunner.find(params[:id])

    respond_to do |format|
      if @roadrunner.update_attributes(params[:roadrunner])
        format.html { redirect_to @roadrunner, notice: 'Roadrunner was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @roadrunner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roadrunners/1
  # DELETE /roadrunners/1.json
  def destroy
    @roadrunner = Roadrunner.find(params[:id])
    @roadrunner.destroy

    respond_to do |format|
      format.html { redirect_to roadrunners_url }
      format.json { head :no_content }
    end
  end
  def execute
    @roadrunner = Roadrunner.find(params[:id])
  end
  def execute2
    @roadrunner = Roadrunner.find(params[:id])
    user_number=params[:user_number].to_i
    iteration_number= params[:iteration_number].to_i
    mode=params[:mode]
    @load= @roadrunner.name  #   从数据库中读取该name
    @load=RoadRunner.new     #   以该name建立实例
    @load.users=user_number
    @load.iterations=iteration_number
    @load.mode=mode
    eval @roadrunner.script      #跑一个保存在数据库中的脚本，脚本实例名为数据库中的name
    @load.run
    @load.report

  end
  def scripts

  end

end
