class Admin::CommunityTestimonialsController < Admin::AdminBaseController
  add_breadcrumb 'Home', :landing_page_without_locale_path

  before_action :set_selected_left_navi_link
  before_action :set_service

  layout false, only: [:edit, :update, :new, :create, :new_unskip, :unskip]
  respond_to :html, :js

  def index
    add_breadcrumb 'Testimonials', admin_community_testimonials_path(@current_community)
  end

  def edit; end

  def update
    @service.update
  end

  def new
    @service.new_testimonial
  end

  def create
    @service.create
  end

  def new_unskip
    @service.new_testimonial
  end

  def unskip
    @service.unskip
    render :create
  end

  private

  def set_selected_left_navi_link
    @selected_left_navi_link = "testimonials"
  end

  def set_service
    @service = Admin::TestimonialsService.new(
      community: @current_community,
      params: params)
  end

end
