class LeaderboardController < ApplicationController
  def index
    @top_users = User.all.sort_by(&:leaderboard_score).reverse.first(10)
  end
end