class WelcomeController < ApplicationController
  before_action :signed_in_user, only: [:index]

  def index
  end
end
