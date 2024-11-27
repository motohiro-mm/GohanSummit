# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RemarksHelper, type: :helper do
  describe '#remark_input_field' do
    it 'remark_typeがproposalのときtext_fieldを返す' do
      remark = build(:remark, remark_type: :proposal)
      options = {
        placeholder: 'カレー、おすし、やきとり',
        autofocus: true,
        class: 'block rounded-md border border-red-950/20  w-full focus:ring-orange-950/50 focus:border-orange-950/50'
      }
      form = instance_double(ActionView::Helpers::FormBuilder)
      allow(form).to receive(:text_field).with('提案', options).and_return('<input ...>')
      result = helper.remark_input_field(form, remark, '提案')
      expect(result).to have_field
    end

    it 'remark_typeがcommentのときtext_areaを返す' do
      remark = build(:remark, remark_type: :comment)
      options = {
        placeholder: '中華の気分、軽めがいい',
        autofocus: true,
        class: 'block rounded-md border border-red-950/20  w-full focus:ring-orange-950/50 focus:border-orange-950/50',
        rows: 1
      }
      form = instance_double(ActionView::Helpers::FormBuilder)
      allow(form).to receive(:text_area).with('コメント', options).and_return('<textarea ...>')
      result = helper.remark_input_field(form, remark, 'コメント')
      expect(result).to have_css 'textarea'
    end
  end

  describe '#form_remark' do
    it 'new_remark_typeがproposalのときproposal_remarkを返す' do
      expect(form_remark(Remark.new, 'proposal')).to eq 'proposal_remark'
    end

    it 'new_remark_typeがcommentのときcomment_remarkを返す' do
      expect(form_remark(Remark.new, 'comment')).to eq 'comment_remark'
    end

    it 'new_remark_typeをとらないときRemarkインスタンスを返す' do
      expect(form_remark(Remark.new)).to be_an_instance_of(Remark)
    end
  end

  describe '#new_button_content' do
    it 'proposalのとき「提案を登録する」が返る' do
      expect(new_button_content('proposal')).to eq '提案を登録する'
    end

    it 'commentのとき「コメントを投稿する」が返る' do
      expect(new_button_content('comment')).to eq 'コメントを投稿する'
    end
  end
end
