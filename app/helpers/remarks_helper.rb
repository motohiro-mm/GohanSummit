# frozen_string_literal: true

module RemarksHelper
  def remark_input_field(form, remark, content)
    options = {
      placeholder: remark_placeholder(remark.remark_type),
      autofocus: true,
      class: 'block rounded-md border border-red-950/20  w-full focus:ring-orange-950/50 focus:border-orange-950/50'
    }

    if remark.remark_type == 'proposal'
      form.text_field(content, options)
    elsif remark.remark_type == 'comment'
      form.text_area(content, options.merge(rows: 1))
    end
  end

  private

  def remark_placeholder(remark_type)
    if remark_type == 'proposal'
      'カレー、おすし、やきとり'
    elsif remark_type == 'comment'
      '中華の気分、軽めがいい'
    end
  end
end
