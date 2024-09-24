# frozen_string_literal: true

module ApplicationHelper
  def css_class_day(day)
    day.strftime('date%Y%m%d')
  end
end
