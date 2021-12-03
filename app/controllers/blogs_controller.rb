class BlogsController < ApplicationController
  def show
    @blog = Blog.friendly.find(params[:id])
  end
end
