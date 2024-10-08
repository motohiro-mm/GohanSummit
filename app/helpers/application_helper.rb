# frozen_string_literal: true

module ApplicationHelper
  def css_class_day(day)
    day.strftime('date%Y%m%d')
  end

  def format_line_break(text)
    safe_join(text.split("\n"), tag.br)
  end
end
