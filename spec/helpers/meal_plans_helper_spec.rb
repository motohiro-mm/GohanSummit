# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MealPlansHelper, type: :helper do
  let(:user) { create(:user) }
  let(:meal_plan) { create(:meal_plan, :with_3_meals, family: user.family) }
  let(:meeting_room) { create(:meeting_room, family: user.family, meal_plan:) }
  let(:new_action) { allow(helper).to receive(:action_name).and_return('new') }
  let(:edit_action) { allow(helper).to receive(:action_name).and_return('edit') }

  describe '#meal_plan_link' do
    let(:date) { Time.zone.today }

    it 'meal_planが存在しないときnew_meal_plan_pathを返す' do
      expect(meal_plan_link(nil, date)).to eq(new_meal_plan_path(meal_date: date))
    end

    it 'meal_planは存在するがmealが存在しないときnew_meal_plan_pathを返す' do
      meal_plan = instance_double(MealPlan, meals: [])
      expect(meal_plan_link(meal_plan, date)).to eq(new_meal_plan_path(meal_date: date))
    end

    it 'meal_planとmealが登録されているときmeal_planを返す' do
      meal_plan
      expect(meal_plan_link(meal_plan, date)).to eq(meal_plan)
    end
  end

  describe '#counter_number_color' do
    it 'meals_lengthが0のときtext-red-400を返す' do
      expect(counter_number_color(nil)).to eq('text-red-400')
    end

    it 'meals_lengthが2のときtext-red-400を返す' do
      meal_plan_tomorrow = create(:meal_plan, :with_breakfast_and_dinner, meal_date: Time.zone.tomorrow, family: user.family)
      expect(counter_number_color(meal_plan_tomorrow)).to eq('text-red-700')
    end

    it 'meals_lengthが3のときtext-red-950/70を返す' do
      meal_plan
      expect(counter_number_color(meal_plan)).to eq('text-red-950/70')
    end
  end

  describe '#meals_length' do
    it 'meal_planが存在しないとき0を返す' do
      expect(meals_length(nil)).to eq(0)
    end

    it 'meal_planは存在するがmealが存在しないとき0を返す' do
      meal_plan = instance_double(MealPlan, meals: nil)
      expect(meals_length(meal_plan)).to eq(0)
    end

    it 'meal_planとmealが3食分登録されているとき3を返す' do
      meal_plan
      expect(meals_length(meal_plan)).to eq(3)
    end
  end

  describe '#proposals_length' do
    it 'meeting_roomが存在しないとき0を返す' do
      meal_plan = instance_double(MealPlan, meeting_room: nil)
      expect(proposals_length(meal_plan)).to eq(0)
    end

    it 'meeting_roomは存在するがproposalsが存在しないとき0を返す' do
      expect(proposals_length(meal_plan)).to eq(0)
    end

    it 'proposalが1つ登録されているとき1を返す' do
      create(:remark, remark_type: 0, content: 'カレー', meeting_room:, user:)
      expect(proposals_length(meal_plan)).to eq(1)
    end
  end

  describe '#comments_length' do
    it 'meeting_roomが存在しないとき0を返す' do
      meal_plan = instance_double(MealPlan, meeting_room: nil)
      expect(comments_length(meal_plan)).to eq(0)
    end

    it 'meeting_roomは存在するがcommentsが存在しないとき0を返す' do
      expect(comments_length(meal_plan)).to eq(0)
    end

    it 'commentが1つ登録されているとき1を返す' do
      create(:remark, remark_type: 1, content: '簡単に作れるものにしよう', meeting_room:, user:)
      expect(comments_length(meal_plan)).to eq(1)
    end
  end

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
