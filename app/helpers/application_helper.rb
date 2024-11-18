# frozen_string_literal: true

module ApplicationHelper

  def cell_day(day)
    day.strftime('cell%Y%m%d')
  end

  def format_date_length_whether_this_year(date)
    date.year == Time.zone.today.year ? :medium : :long
  end

  def format_line_break(text)
    safe_join(text.split("\n"), tag.br)
  end
end
