# frozen_string_literal: true

module ApplicationHelper
  def row_day(day)
    day.strftime('row%Y%m%d')
  end

  def cell_day(day)
    day.strftime('cell%Y%m%d')
  end

  def format_line_break(text)
    safe_join(text.split("\n"), tag.br)
  end
end
