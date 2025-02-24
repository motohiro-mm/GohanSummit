# frozen_string_literal: true

module ApplicationHelper
  def format_date_length_whether_this_year(date)
    date.year == Time.zone.today.year ? :medium : :long
  end

  def default_meta_tags
    {
      site: 'ごはんサミット',
      reverse: true,
      charset: 'utf-8',
      description: 'ごはんサミットは、家族で献立を相談したり、献立表を共有できるアプリです。',
      keywords: 'ごはんサミット, gohansummit, ごはん, サミット, 会議, kaigi, 献立, 献立表',
      og: {
        title: :title,
        type: 'website',
        site_name: 'ごはんサミット',
        description: :description,
        image: image_url('ogp.png'),
        url: 'https://gohansummit.com',
        local: 'ja-JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@motohiromm'
      }
    }
  end

  def vapid_public_key_bytes
    @vapid_public_key_bytes ||= Base64.urlsafe_decode64(Rails.application.credentials.webpush.public_key).bytes
  end
end
