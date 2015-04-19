require 'DayOff'
require 'my_log'


class VacationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_admin, :only => [:edit, :destroy]
  before_action :set_vacation, only: [:show, :edit, :update, :destroy]

  # GET /vacations
  # GET /vacations.json
  def index
    @vacations = Vacation.all
    respond_to do |format|
    format.html
    format.csv { render text: @vacations.to_csv }
    
    @search = VacationSearch.new(params[:search])
    @vacations = @search.scope
    

   
   @theDay = Vacation.all
    @dayData = []
   
    @theDay.each do |n| 
       @myDay = DayOff.myDay(n.days)
    #   if @dayOut != 0
         @dayData << n.days
    #   else
      #   @dayData << n.days
     #  end
    end
    
    end
  end
    
  # GET /vacations/1
  # GET /vacations/1.json
  def show
  end

  # GET /vacations/new
  def new
    @vacation = Vacation.new
   
  end

  # GET /vacations/1/edit
  def edit
  end

  # POST /vacations
  # POST /vacations.json
  def create
    
    
    @vacation = Vacation.new(vacation_params)
    
      # retrieve the instance/object of the MyLogger class
    logger = MyLog.instance
    logger.logInformation("A new Vacation was requested: " + @vacation.date )
    
    
    respond_to do |format|
      if @vacation.save
        format.html { redirect_to @vacation, notice: 'Vacation was successfully created.' }
        format.json { render :show, status: :created, location: @vacation }
      else
        format.html { render :new }
        format.json { render json: @vacation.errors, status: :unprocessable_entity }
        
        
      end
    end
    
    end

  # PATCH/PUT /vacations/1
  # PATCH/PUT /vacations/1.json
  def update
    respond_to do |format|
      if @vacation.update(vacation_params)
        format.html { redirect_to @vacation, notice: 'Vacation was successfully updated.' }
        format.json { render :show, status: :ok, location: @vacation }
      else
        format.html { render :edit }
        format.json { render json: @vacation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vacations/1
  # DELETE /vacations/1.json
  def destroy
    @vacation.destroy
    respond_to do |format|
      format.html { redirect_to vacations_url, notice: 'Vacation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def import 
  	Vacation.import(params[:file])
  	redirect_to vacations_path, notice: "Vacations Added"
  end
  
  def ensure_admin
    unless current_user && current_user.admin?
    render :text => "Access Error Message", :status => :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vacation
      @vacation = Vacation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vacation_params
      params.require(:vacation).permit(:date, :days, :employee_id, :dept, :status_type)
    end
end