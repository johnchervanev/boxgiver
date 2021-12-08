class BlogsController < ApplicationController

  def index
    @blogs = Blog.where(published: true).paginate(page: params[:page], per_page: 9)
  end

  def show
    @blog = Blog.friendly.find(params[:id])
  end
end
