class LinksController < ApplicationController
  # needs admin permission

  def index
    # show all links
    @links = Link.all()
  end

  # actually i don't need show page
  # but should have search feature
  # this gonna be implemented with angular.js

  # New -> Create
  def new
    @link = Link.new()
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      redirect_to links_path
    else
      flash[:error] = "error"
      render "new"
    end
  end

  # Edit -> Update
  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if @link.save
      redirect_to links_path
    else
      flash[:error] = "Error"
      render "edit"
    end
  end

  def destroy
    link = Link.find(params[:id])
    if link.destroy
      flash[:success] = "delete success"
    else
      flash[:error] = "delete failed"
    end

    redirect_to links_path
  end

  private
    def link_params
      params.require(:link).permit(:original, :shorten, :message)
    end
end
