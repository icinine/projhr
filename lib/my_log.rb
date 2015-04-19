require 'singleton'

class MyLog
  include Singleton

    def initialize
      @log = File.open("this_log.txt", "a")
    end
   
    def logInformation(information)
      @log.puts(information)
      @log.flush
    end
end