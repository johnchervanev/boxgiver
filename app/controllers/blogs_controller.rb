class BlogsController < ApplicationController
  add_breadcrumb "Home", :landing_page_without_locale_path

  def index
    add_breadcrumb "Blog", blog_index_path
    @blogs = Blog.where(published: true).paginate(page: params[:page], per_page: 9)
  end

  def show
    @blog = Blog.friendly.find(params[:id])
    add_breadcrumb blog.title, blog_path(@blog)
  end
end
