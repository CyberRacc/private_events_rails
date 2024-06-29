class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :authorize_user, only: [:show]

  def show
    @user = User.find(params[:id])
  end

  private

  def authorize_user
    if current_user.id != params[:id].to_i
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
