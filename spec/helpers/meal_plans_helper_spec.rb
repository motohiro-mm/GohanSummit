# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MealPlansHelper, type: :helper do
  let(:new_action) { allow(helper).to receive(:action_name).and_return('new') }
  let(:edit_action) { allow(helper).to receive(:action_name).and_return('edit') }

  describe '#form_url' do
    let(:meal_plan) { instance_double(MealPlan) }

    it 'newアクションのときmeal_plans_pathを返す' do
      new_action
      expect(helper.form_url(meal_plan)).to eq(meal_plans_path)
    end

    it 'editアクションのときmeal_plan_pathを返す' do
      edit_action
      expect(helper.form_url(meal_plan)).to eq(meal_plan_path(meal_plan))
    end
  end

  describe '#form_method' do
    it 'newアクションのとき:postを返す' do
      new_action
      expect(helper.form_method).to eq(:post)
    end

    it 'editアクションのとき:patchを返す' do
      edit_action
      expect(helper.form_method).to eq(:patch)
    end
  end

  describe '#button_display' do
    it 'newアクションのとき「登録」を返す' do
      new_action
      expect(helper.button_display).to eq('登録')
    end

    it 'editアクションのとき「更新」を返す' do
      edit_action
      expect(helper.button_display).to eq('更新')
    end
  end
end
