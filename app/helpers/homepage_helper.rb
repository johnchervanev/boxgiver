module HomepageHelper
  def show_subcategory_list(category, current_category_id)
    category.id == current_category_id || category.children.any? do |child_category|
      child_category.id == current_category_id
    end
  end

  def with_first_listing_image(listing, &block)
    if listing.listing_images.size == 0
      block.call(asset_path('no_image_available.jpg'))
    else
      Maybe(listing)
        .listing_images
        .map { |images| images.first }[:medium].each { |url|
        block.call(url)
      }
    end
  end

  def with_first_love_listing_image(listing, &block)
    if listing.listing_images.size == 0
      block.call(asset_path('no_image_available.jpg'))
    else
      image_url = listing.listing_images.first.image(:medium)
      block.call(image_url)
    end
  end

  def without_listing_image(listing, &block)
    if listing.listing_images.size == 0
      block.call
    end
  end

  def love_button(listing, user, klass = '')
    if user.present?
      loved = user.is_loving?(listing)
      ct = Listing.love_count(listing.id)
      sct = "<span class='love-count'> #{ct} </span>"
      link_to(raw(sct), love_listing_path(listing.id), :class => "icon-heart listing-love right-side #{klass} love-#{listing.id}-listing #{ loved ? 'active' : ''}", :title => "#{loved ? 'Remove from love' : 'Click to love'}", :method => :post, :remote => :true)
    else
      link_to(raw(sct), login_path, :class => "icon-heart listing-love #{klass} right-side love-#{listing.id}-listing")
    end
  end

  def format_distance(distance)
    precision = (distance < 1) ? 1 : 2
    (distance < 0.1) ? "< #{number_with_delimiter(0.1, locale: locale)}" : number_with_precision(distance, precision: precision, significant: true, locale: locale)
  end
end
