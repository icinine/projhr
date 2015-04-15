class Dept < ActiveRecord::Base
  has_many :Employees
end
