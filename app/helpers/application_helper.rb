module ApplicationHelper
  def format_url(url)
    url.starts_with?("http://", "https://") ? url : "http://" + url
  end

  def format_datetime(dt)
    if logged_in? && !current_user.time_zone.blank?
      dt = dt.in_time_zone(current_user.time_zone)
    end
      dt.strftime("%m/%d/%Y %I:%M%P %Z")
  end


  def shorten_body(body)
   body.length < 240 ? body : body[0..237] + "..."
  end
  
end
