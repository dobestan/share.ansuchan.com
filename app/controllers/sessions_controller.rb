class SessionsController < ApplicationController
  before_action :not_signed_in_user, only: [:new]

  # Sign In
  def new
  end

  def create
    user = User.find_by(name: session_params[:name])
    if user && user.authenticate(session_params[:password])
      # Sign in Success
      sign_in user
      redirect_back_or root_path
    else
      # Sign in Failed
      flash[:error] = "Invalid Email / Password Combination"
      render 'new'
    end
  end

  # Sign Out
  def destroy
    sign_out
    redirect_to root_path
  end

  private
    def session_params
      params.require(:session).permit(:name, :password)
    end
end
