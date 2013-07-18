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
end
