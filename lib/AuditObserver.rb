 class AuditObserver < ActiveRecord::Observer
  observe :vacation

  def after_update(vacation)
    AuditTrail.new(vacation, "UPDATED")
  end
end