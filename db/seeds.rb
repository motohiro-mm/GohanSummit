# frozen_string_literal: true

DISHES = %w[からあげ やきそば おこのみやき ビビンバ カレー ラーメン 焼き鳥 餃子 ハンバーグ おすし オムライス キムチ鍋 生姜焼き うどん ハンバーガー].freeze

COMMENTS = %w[たくさん食べたいな あっさりの気分 時間ないよね なんでもいいな〜 がっつりしたものが食べたい 一から作ってもいいよね 寒そうだからあったかいものが食べたい 何食べたい気分？ 最近肉料理多いよね 簡単に作れるものがいいな].freeze

local_family = Family.find_or_create_by!(invitation_token: 'fbc20240915gohan')

user1 = User.find_or_create_by!(uid: '3141592653589793238462643383279') do |u|
  u.name = 'もとみ'
  u.provider = 'google_oauth2'
  u.family = local_family
  u.icon = 2
end

user2 = User.find_or_create_by!(uid: '50288419716939937510') do |u|
  u.name = 'もとた'
  u.provider = 'google_oauth2'
  u.family = local_family
  u.icon = 10
end

[0, 2, 4, 6].each do |n|
  local_meal_plan = MealPlan.find_or_create_by!(meal_date: Time.zone.today.days_since(n)) do |meal_plan|
    meal_plan.family = local_family
    (0..2).each do |timing_n|
      meal_plan.meals.build(
        name: DISHES.sample,
        timing: timing_n
      )
    end
  end

  local_meeting_room = MeetingRoom.find_or_create_by!(meal_plan: local_meal_plan, family: local_family)

  [user1, user2, user1].each do |user|
    Remark.create!(
      meeting_room: local_meeting_room,
      remark_type: 0,
      content: DISHES.sample,
      user: user
    )
    Remark.create!(
      meeting_room: local_meeting_room,
      remark_type: 1,
      content: COMMENTS.sample,
      user: user
    )
  end
end
