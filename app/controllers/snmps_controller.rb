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
        format.html { redirect_to @snmp, notice: 'Simulator was successfully created.' }
        format.json { render json: @snmp, status: :created, location: @snmp }
      else
        format.html { render action: "new" }
        format.json { render json: @snmp.errors, status: :unprocessable_entity }
      end

    end

    `echo 123456789|sudo -S ifconfig eth0:#{@snmp.name} down`
    `echo 123456789|sudo -S ifconfig eth0:#{@snmp.name} #{@snmp.simulated_ip} netmask 255.255.255.255 up`

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

   system('echo 123456789|sudo -S ifconfig eth0:#{@snmp.name} down')
    @snmp.destroy
    FileUtils.rm_r Dir.glob("#{Rails.root.join('public','uploads',@snmp.simulated_ip)}/*"),:force =>true

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
     `ps -fe|grep #{session[:executed_snmp].simulated_ip}|grep -v grep|awk '{print "kill -9 ",$2}'|sh` #make sure kill

     @uploadfile = params[:attachment]
     working_path = Rails.root.join('public','uploads',session[:executed_snmp].simulated_ip)

     unless File.directory?(working_path)
       FileUtils.mkdir_p(working_path)
     end       #建文件夹
      File.open("#{working_path}/#{@uploadfile.original_filename}",'w+') do |file|
        file.write(@uploadfile.read)
      end     #写文件，保存
     @txt = String.new
    fs= File.new("#{working_path}/#{@uploadfile.original_filename}")

        fs.each_line do |line|
          if fs.lineno == 1
          else
          ar=line.split('","')
          @txt << "#{ar[0].delete('"')}|#{parse_tag(ar[2])}|#{ar[1]}\n"
           end
       end

    rec_file = File.new("#{working_path}/#{params[:community]}.snmprec",'w')
    rec_file.print @txt
    rec_file.close

   # puts `whoami`
    `echo 123456789|sudo -S snmpsimd.py  --agent-udpv4-endpoint=#{session[:executed_snmp].simulated_ip}:#{params[:port]} --device-dir=#{working_path} --process-user=josh --process-group=root >#{working_path}/snmp.log 2>&1 &`

     puts "I wanna validate"
     @snmp = Snmp.find(session[:executed_snmp].id)
     @snmp.status= "on"
     @snmp.save

  end

  def off
    @snmp =Snmp.find(params[:id])
    `ps -fe|grep #{@snmp.simulated_ip}|grep -v grep|awk '{print "kill -9 ",$2}'|sh`
    working_path= Rails.root.join('public','uploads',@snmp.simulated_ip)
    FileUtils.rm_r Dir.glob("#{working_path}/*"),:force =>true
    @snmp.status='down'
    @snmp.save
    redirect_to snmp_path , notice: 'Simulator was successfully turned off.'
  end
  def log
    render :file => "#{Rails.root.join('public','uploads',session[:executed_snmp].simulated_ip)}/snmp.log"
  end

  def record

  end

  def recording
     `snmprec.py --agent-udpv4-endpoint=#{params[:ip]} --community=#{params[:community]} --output-file="./tmp/#{params[:ip]}.snmprec"`
     send_file "./tmp/#{params[:ip]}.snmprec",:file_name=>"#{params[:ip]}.snmprec",:disposition => "attachment"
     File.delete "./tmp/#{params[:ip]}.snmprec"
  end

  def rec
    @snmp =Snmp.find(params[:id])
    session[:executed_snmp]||= Snmp.new      #为今后生成报告，产生Session
    session[:executed_snmp] = @snmp
  end

  def upload_rec
    `ps -fe|grep #{session[:executed_snmp].simulated_ip}|grep -v grep|awk '{print "kill -9 ",$2}'|sh` #make sure kill
    @uploadfile = params[:attachment]
    working_path= Rails.root.join('public','uploads',session[:executed_snmp].simulated_ip)
    unless File.directory?(working_path)
      FileUtils.mkdir_p(working_path)
    end       #建文件夹
    File.open("#{working_path}/#{params[:community]}.snmprec",'w+') do |file|
      file.write(@uploadfile.read)
    end

     `echo 123456789|sudo -S snmpsimd.py  --agent-udpv4-endpoint=#{session[:executed_snmp].simulated_ip}:#{params[:port]} --device-dir=#{working_path} --process-user=josh --process-group=root >#{working_path}/snmp.log 2>&1 &`
    @snmp = Snmp.find(session[:executed_snmp].id)
    @snmp.status= "on"
    @snmp.save

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
        '64x'
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
      when 'OctetString:PhysicalAddress' then
        4
      when 'OctetString:UInteger32' then
        5
      when 'RFC2578_Unsigned32' then
        66
      else
        4
    end
  end


end
