class Admin::BlogsController < ApplicationController
  before_action :set_selected_left_navi_link
  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.community_id = @current_community.id
    @blog.author_id = current_user.id
    if @blog.save
      redirect_to admin_blogs_path
    else
      render :new
    end
  end

  def edit
    @blog = Blog.friendly.find(params[:id])
  end

  def show
    @blog = Blog.friendly.find(params[:id])
  end

  def update
    @blog = Blog.friendly.find(params[:id])

    if @blog.update(blog_params)
      redirect_to admin_blogs_path
    else
      render :edit
    end
  end

  def destroy
    @blog = Blog.friendly.find(params[:id])
    @blog.destroy
    redirect_to admin_blogs_path
  end

  private
  def blog_params
    params.require(:blog).permit(:community_id, :author_id, :title, :content, :image, :slug, :published, :minutes)
  end

  def set_selected_left_navi_link
    @selected_left_navi_link = "blogs"
  end

end
