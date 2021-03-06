class TracksController < ApplicationController

  before_action :current_user

  def create
    @room = Room.find(params[:room])
    track = @room.tracks.create({
      user_id: current_user.id,
      sequence: params[:sequence],
      instrument: params[:instrument]
      })
    if track.save
      alert_msg = "Track successfully saved!"
    else
      alert_msg = "Error saving track - make sure an instrument is selected and that the track is not empty!"
    end
    return_data = { object: track, user: current_user.name, msg: alert_msg }

    respond_to do |format|
      format.html { redirect_to "/rooms/#{@room.id}"}
      format.json { render json: return_data.to_json }
    end
  end

end