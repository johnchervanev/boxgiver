class BlogsController < ApplicationController

  def index
    @blogs = Blog.where(published: true)
  end

  def show
    @blog = Blog.friendly.find(params[:id])
  end
end
