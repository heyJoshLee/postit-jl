module ApplicationHelper
  def format_url(url)
    url.starts_with?("http://") ? url : "http://" + url
  end

  def format_datetime(dt)
    if logged_in? && !current_user.time_zone.blank?
      dt = dt.in_time_zone(current_user.time_zone)
    end
      dt.strftime("%m/%d/%Y %I:%M%P %Z")
  end

  
end
