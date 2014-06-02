class LinksController < ApplicationController
  before_action :signed_in_user, only: [:index]
  before_action :admin_user, only: [:new, :create, :edit, :update, :destroy]

  # needs admin permission

  def index
    # show all links
    if current_user.admin?
      @links = Link.all
    else
      @links = Link.where(public: true)
    end

    respond_to do |format|
      format.html
      format.json { render json: @links }
    end
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
    if @link.update_attributes(link_params)
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

  def redirect
    link = Link.find_by(shorten: params[:shorten])
    if link && link.public
      redirect_to link.original
    elsif link && !link.public
      # should ask for password
      redirect_to link_authenticate_path(shorten: link.shorten)
    else
      flash[:success] = "요청하신 페이지를 찾을 수 없습니다."
      redirect_to root_path
    end
  end

  def authenticate
    @link = Link.find_by(shorten: params[:shorten])

    if @link.public || @link.authenticate.nil?
      # if link is public -> show all ( include demo user )
      # if link has no authenticate key -> direct redirect
      redirect_to @link.original
    end
  end

  def redirect_with_authenticate
    link = Link.find_by(shorten: params[:shorten])
    if link.authenticate == authenticate_params[:key]
      # Success
      redirect_to link.original
    else
      redirect_to link_authenticate_path(link.shorten)
    end
  end

  private
    def link_params
      params.require(:link).permit(:original, :shorten, :public, :authenticate)
    end

    def authenticate_params
      params.require(:authenticate).permit(:key)
    end
end
