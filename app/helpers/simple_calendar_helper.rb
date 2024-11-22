# frozen_string_literal: true

module SimpleCalendarHelper
  def cell_day(day)
    day.strftime('cell%Y%m%d')
  end
end
