class Dept < ActiveRecord::Base
  has_many :employee
end
