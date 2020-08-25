module AttendancesHelper
  
  def working_times(start, finish)
    format("%.2f", ((finish - start) / 3600.00))
  end

end
