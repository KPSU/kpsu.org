module VolunteerHoursHelper

  def total_monthly_volunteer_hours
    @tmp = User.all
    @m = Time.zone.now.month
    @days = days_in_month(@m)
    @total = 0
    Rails.logger.info @days
    Rails.logger.info @m
    @tmp.each do |u|
      @n = u.monthly_hours(@m, @days)
      @total += @n
    end
    return @total
  end
  
end
