require 'fileutils'

class SnmpsController < ApplicationController
  # GET /snmps
  # GET /snmps.json
  def index
    @snmps = Snmp.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @snmps }
    end
  end

  # GET /snmps/1
  # GET /snmps/1.json
  def show
    @snmp = Snmp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @snmp }
    end
  end

  # GET /snmps/new
  # GET /snmps/new.json
  def new
    @snmp = Snmp.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @snmp }
    end
  end

  # GET /snmps/1/edit
  def edit
    @snmp = Snmp.find(params[:id])
  end

  # POST /snmps
  # POST /snmps.json
  def create
    @snmp = Snmp.new(params[:snmp])

    respond_to do |format|
      if @snmp.save
        format.html { redirect_to @snmp, notice: 'Snmp was successfully created.' }
        format.json { render json: @snmp, status: :created, location: @snmp }
      else
        format.html { render action: "new" }
        format.json { render json: @snmp.errors, status: :unprocessable_entity }
      end

    end

    `echo 1|sudo -S ifconfig eth0:#{@snmp.name} down`
    `echo 1|sudo -S ifconfig eth0:#{@snmp.name} #{@snmp.simulated_ip} netmask 255.255.255.255 up`

  end

  # PUT /snmps/1
  # PUT /snmps/1.json
  def update
    @snmp = Snmp.find(params[:id])

    respond_to do |format|
      if @snmp.update_attributes(params[:snmp])
        format.html { redirect_to @snmp, notice: 'Snmp was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @snmp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /snmps/1
  # DELETE /snmps/1.json
  def destroy
    @snmp = Snmp.find(params[:id])

   system('echo 1|sudo -S ifconfig eth0:#{@snmp.name} down')
    @snmp.destroy

    respond_to do |format|
      format.html { redirect_to snmps_url }
      format.json { head :no_content }
    end
  end

  def csv
    @snmp =Snmp.find(params[:id])
    session[:executed_snmp]||= Snmp.new      #为今后生成报告，产生Session
    session[:executed_snmp] = @snmp
  end

  def upload
     @uploadfile = params[:attachment]
     unless File.directory?(Rails.root.join('public','uploads',session[:executed_snmp].simulated_ip))
       FileUtils.mkdir_p(Rails.root.join('public','uploads',session[:executed_snmp].simulated_ip))
     end
      File.open(Rails.root.join('public','uploads',session[:executed_snmp].simulated_ip,@uploadfile.original_filename),'w+') do |file|
        file.write(@uploadfile.read)
      end     #写文件，保存
     @txt = String.new
    File.open(Rails.root.join('public','uploads',session[:executed_snmp].simulated_ip,@uploadfile.original_filename)) do |row|
           row.each_line do |line|
         ar=line.split('","')
         @txt << "#{ar[0].delete('"')}|#{parse_tag(ar[2])}|#{ar[1]}\n"
       end
    end

  end
 private
  def parse_tag(val)
    case val
      when 'Integer' then
        2
      when 'OctetString' then
        4
      when 'Null' then
        5
      when 'ObjectIdentifier' then
        6
      when 'IPAddress' then
        64
      when 'Counter32' then
        65
      when 'Gauge32' then
        66
      when 'TimeTicks' then
        67
      when 'Opaque' then
        68
      when 'Counter64' then
        70
      else
        5
    end
  end


end
