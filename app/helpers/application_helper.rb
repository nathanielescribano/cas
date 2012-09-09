# this is bad - but its a hackathon so whatever
module ApplicationHelper

  def get_locu_client
    api_key = '4b11590e2053dbe2b02adbc82c30f48dcf78dfec'
    lc = Locu::Client.new(api_key)
  end

  def menu_item_data(lc, search_hash)
    if !search_hash[:latitude].blank? && !search_hash[:longitude].blank?
      lat_and_long = "#{search_hash[:latitude]},#{search_hash[:longitude]}"
    else
      # we are hardcoding the lat and longitude
      # to sf for dome purposes
      lat_and_long = "37.778,-122.422"
    end

    lc_result_hash  = lc.menu.search_by({ :name => search_hash['menu_item'],
                                          :price__lte => search_hash['money_left'],
                                          :radius => 6000,
                                          :location => lat_and_long})
    mi = MenuItem.new(lc_result_hash)
    mi.item_list_with(['id', 'name', 'price', 'venue'])
  end

  def menu_item_data_from_param(p)
    {:id => p[:id], :name => p[:name], :price => p[:price], :lat => p[:lat], :long => p[:long]}
  end

  def find_vendor_by_menu_item_id(id)
    logger.info "http://api.locu.com/v1_0/menu_item/#{id}/?api_key=4b11590e2053dbe2b02adbc82c30f48dcf78dfec"
    url = URI.parse("http://api.locu.com/v1_0/menu_item/#{id}/?api_key=4b11590e2053dbe2b02adbc82c30f48dcf78dfec")
    res = Net::HTTP.get_response(url)
    if res.is_a?(Net::HTTPSuccess)
      mi = MenuItem.new(JSON.parse(res.body)) if res.is_a?(Net::HTTPSuccess)
    else
      return nil
    end
    
    venue_id =  mi.find_venue_id_by_id(id)
    logger.info "http://api.locu.com/v1_0/venue/#{venue_id}/?api_key=4b11590e2053dbe2b02adbc82c30f48dcf78dfec"
    url = URI.parse("http://api.locu.com/v1_0/venue/#{venue_id}/?api_key=4b11590e2053dbe2b02adbc82c30f48dcf78dfec")
    res = Net::HTTP.get_response(url)
    Venue.new(JSON.parse(res.body))
  end

  def sorted_menu_item_data(lc, search_hash)
    mid = menu_item_data(lc, search_hash)
    mid.sort_by { |a| a["price"] }
  end

  def sorted_menu_item_data_with_vendor(lc, search_hash)
    lat_and_long = "#{search_hash['lat']},#{search_hash['long']}"

    lc_result_hash  = lc.menu.search_by({ :name => search_hash['menu_item'],
                                          :price__lte => search_hash['money_left'],
                                          :radius => 5,
                                          :location => lat_and_long })
    mi = MenuItem.new(lc_result_hash)
    mid = mi.item_list_with(['id', 'name', 'price', 'venue'])
    mid.sort_by { |a| a["price"] }
  end

end
