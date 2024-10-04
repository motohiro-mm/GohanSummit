# frozen_string_literal: true

module MealsHelper
  def format_memo(meal)
    safe_join(meal.memo.split("\n"), tag.br)
  end
end
