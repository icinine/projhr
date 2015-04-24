require 'my_log'
class VacationObserver < ActiveRecord::Observer
  def after_update(record)
    # use the MyLogger instance method to retrieve the single instance/object of the class
    @logger = MyLog.instance
    # use the logger to log/record a message about the updated vacation
    @logger.logInformation("###############Observer Demo:#")
    @logger.logInformation("+++ Vacationbserver: The Vacation of
    #{record.name} 
    has been updated. Details: #{record.date}")
    @logger.logInformation("##############################")
  end
end