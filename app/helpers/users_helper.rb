module UsersHelper
  
  def format_basic_info(time)
    format("%.2f", (time.hour + (time.min / 60.0)))
  end
  
  def minute_change(time)
    case time 
      when 0..14
        min = 0
      when 15..29
        min = 15
      when 30..44
        min = 30
      when 45..59
        min = 45
    end
    return min
  end
  
end
