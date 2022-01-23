class Admin::CommunityInvitationsController < Admin::AdminBaseController
  add_breadcrumb 'Home', :landing_page_without_locale_path
  before_action :set_selected_left_navi_link
  before_action :set_service

  def index
    add_breadcrumb 'Invitations', admin_community_invitations_path(@current_community)
  end

  private

  def set_selected_left_navi_link
    @selected_left_navi_link = "invitations"
  end

  def set_service
    @service = Admin::InvitationsService.new(
      community: @current_community,
      params: params)
  end
end
