class Vacation < ActiveRecord::Base
  #belongs_to :name
  belongs_to :employee
  
  def self.to_csv
  CSV.generate do |csv|
    csv << column_names
      all.each do |vacation|
        csv << vacation.attributes.values_at(*column_names)
    end
  end
end



end