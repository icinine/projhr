class Employee < ActiveRecord::Base
  belongs_to :dept
  has_many :vacations
end
