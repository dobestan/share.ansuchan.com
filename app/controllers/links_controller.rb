class LinksController < ApplicationController
  # needs admin permission

  def index
    # show all links
  end

  def new
    @link = Link.new()
  end
end
