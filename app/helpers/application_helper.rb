module ApplicationHelper
  def format_url(url)
    url.starts_with?("http://") ? url : "http://" + url
  end

  def format_datetime(dt)
    dt.strftime("%m/%d/%Y %I:%M%P")
  end

  def can_delete?(object)
    (object.creator  && object.creator.username == (logged_in? && current_user.username) || 
    current_user.role == "admin" )
  end
end
