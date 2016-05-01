module ApplicationHelper
  def format_url(url)
    url.starts_with?("http://") ? url : "http://" + url
  end

  def format_datetime(dt)
    dt.strftime("%m/%d/%Y %I:%M%P")
  end

  
end
