# frozen_string_literal: true

module RemarksHelper
  def remark_placeholder(remark_type)
    if remark_type == 'proposal'
      'カレー、おすし、やきとり'
    elsif remark_type == 'comment'
      '中華の気分、軽めがいい'
    end
  end
end
