# this is bad - but its a hackathon so whatever
module ApplicationHelper

  def get_locu_client
    api_key = '4b11590e2053dbe2b02adbc82c30f48dcf78dfec'
    lc = Locu::Client.new(api_key)
  end

  def menu_item_data(lc, search_hash)
    lc_result_hash  = lc.menu.search_by({ :name => search_hash['menu_item'],
                                          :price__lte => search_hash['money_left']})
    mi = MenuItem.new(lc_result_hash)
    mi.item_list_with(['id', 'name', 'price'])
  end

  def menu_item_data_from_param(p)
    {:id => p[:id], :name => p[:name], :price => p[:price]}
  end

  def find_vendor_by_menu_item_id(id)
    lc = get_locu_client
    lc_result_hash  = lc.menu.search_by_id id
    mi = MenuItem.new(lc_result_hash)
    mi.find_venue_id_by_id(id)
  end

end
