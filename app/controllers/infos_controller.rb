class InfosController < ApplicationController

  add_breadcrumb "Home", :landing_page_without_locale_path

  #Allow infos to be viewed before email confirmation
  skip_before_action :cannot_access_without_confirmation

  def about
    add_breadcrumb "About", about_path

    @selected_tribe_navi_tab = "about"
    @selected_left_navi_link = "about"
  end

  def how_to_use
    add_breadcrumb "How it works", how_to_use_path

    @selected_tribe_navi_tab = "about"
    @selected_left_navi_link = "how_to_use"
    content = if @community_customization && !@community_customization.how_to_use_page_content.nil?
      @community_customization.how_to_use_page_content.html_safe
    else
      MarketplaceService.how_to_use_page_default_content(I18n.locale, @current_community.name(I18n.locale))
    end
    render locals: { how_to_use_content: content }
  end

  def terms
    add_breadcrumb "Terms of use", terms_path

    @selected_tribe_navi_tab = "about"
    @selected_left_navi_link = "terms"
  end

  def privacy
    add_breadcrumb "Privacy policy", privacy_path

    @selected_tribe_navi_tab = "about"
    @selected_left_navi_link = "privacy"
  end

  def faq
    add_breadcrumb "FAQ", faq_path

    @selected_tribe_navi_tab = "about"
    @selected_left_navi_link = "faq"
  end

  private

  def how_to_use_content?
    Maybe(@community_customization).map { |customization| !customization.how_to_use_page_content.nil? }
  end
end
