module ApplicationHelper
  def format_datetime(datetime)
    datetime.in_time_zone('Asia/Kolkata').strftime('%I:%M %p %d/%m/%Y')
  end
end
