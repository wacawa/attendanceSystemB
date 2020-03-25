module UsersHelper
  
  def format_basic_info(time)
    format("%.2f", (time.hour + (time.min / 60.0)))
  end
  
end
