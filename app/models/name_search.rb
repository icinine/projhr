class NameSearch 
  attr_reader :my_name
  
  def initialize(params)
    params ||= {}
    @my_name = parsed_name(params[:my_name], my_name.to_s)
   # @date_to = parsed_date(params[:date_to], Date.today.to_s)

  end
  
  def scope
   Vacation.where('name EQUALS ?', @my_name)
  end
  
  private
  
  def parsed_name(name_string, default)
    #Text.parse(name_string)
  rescue ArgumentError, TypeError
    default
  end
  
end