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
 
        # For URL like /employees/1/vacations
        # Get the employee with id=1
       @employee = Employee.find(params[:employee_id])
    
        # Access all vacations for that employee
      @vacations = @employee.vacations
      end
      
       
  end
    
  # GET /vacations/1
  # GET /vacations/1.json
  def show
     @employee = Employee.find(params[:employee_id])

    # For URL like /customers/1/vacations/2
    # Find an vacation in customers 1 that has id=2
    @vacation = @employee.vacations.find(params[:id])
  end

  # GET /vacations/new
  def new
    @vacation = Vacation.new
    @employee = Employee.find(params[:employee_id])


    # Associate an vacation object with customer 1
    @vacation = @employee.vacations.build
  end

  # GET /vacations/1/edit
  def edit
      @employee = Employee.find(params[:employee_id])

    # For URL like /customers/1/vacations/2/edit
    # Get vacation id=2 for customer 1
    @vacation = @employee.vacations.find(params[:id])
  end

  # POST /vacations
  # POST /vacations.json
  def create
    @vacation = Vacation.new(vacation_params)

    respond_to do |format|
      if @vacation.save
        format.html { redirect_to @vacation, notice: 'Vacation was successfully created.' }
        format.json { render :show, status: :created, location: @vacation }
      else
        format.html { render :new }
        format.json { render json: @vacation.errors, status: :unprocessable_entity }
      end
    end
    
    @employee = Employee.find(params[:employee_id])

    # For URL like /customers/1/vacations
    # Populate an vacation associate with customer 1 with form data
    # Employee will be associated with the vacation
    @vacation = @employee.vacations.build(params.require(:vacation).permit(:details))
    if @vacation.save
      # Save the vacation successfully
      redirect_to employee_vacation_url(@employee, @vacation)
    else
      render :action => "new"
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
    
    
     @employee = Employee.find(params[:employee_id])
    @vacation = Order.find(params[:id])
    if @vacation.update_attributes(params.require(:vacation).permit(:name))
      # Save the vacation successfully
      redirect_to employee_vacation_url(@employee, @vacation)
    else
      render :action => "edit"
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
    
    
      @employee = Employee.find(params[:employee_id])
      @vacation = Vacation.find(params[:id])
      @vacation.destroy

    respond_to do |format|
      format.html { redirect_to employee_vacations_path(@employee) }
      format.xml  { head :ok }
    end
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
