# frozen_string_literal: true

class RemarksController < ApplicationController
  before_action :set_meeting_room, only: %i[new create edit update destroy]
  before_action :set_remark, only: %i[edit update destroy]
  def new
    @remark = Remark.build(remark_type: params[:remark_type])
  end

  def edit; end

  def create
    @remark = current_user.remarks.build(remark_params)
    if @remark.save
      flash.now[:notice] = '投稿しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @remark.update(remark_params)
      flash.now[:notice] = '更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @remark.destroy!

    flash.now[:notice] = '削除しました'
  end

  private

  def set_meeting_room
    @meeting_room = current_family.meeting_rooms.find(params[:meeting_room_id])
  end

  def set_remark
    @remark = @meeting_room.remarks.find(params[:id])
  end

  def remark_params
    params.require(:remark).permit(:meeting_room_id, :remark_type, :content)
  end
end
