# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#format_date_length_whether_this_year' do
    it '日付が明日ならmediumを返す' do
      expect(format_date_length_whether_this_year(Time.zone.tomorrow)).to eq :medium
    end

    it '日付が来年ならlongを返す' do
      expect(format_date_length_whether_this_year(Time.zone.today.next_year)).to eq :long
    end
  end
end
