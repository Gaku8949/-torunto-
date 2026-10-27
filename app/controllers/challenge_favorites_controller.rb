class ChallengeFavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @challenge = Challenge.find(params[:challenge_id])

    @favorite = @challenge.challenge_favorites.find_or_initialize_by(
      user: current_user
    )

    @favorite.save

    redirect_back(fallback_location: challenges_path)
  end

  def destroy
    @challenge = Challenge.find(params[:challenge_id])

    @favorite = @challenge.challenge_favorites.find_by(
      user: current_user
    )

    @favorite&.destroy

    redirect_back(fallback_location: challenges_path)
  end
end