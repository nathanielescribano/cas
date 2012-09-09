class PagesController < ActionController::Base
  protect_from_forgery

  before_filter :set_api_key

  def index
    @menu_item_data = get_menu_item_data
  end

  # this is bad - but its a hackathon so whatever
  def set_api_key
    api_key = '4b11590e2053dbe2b02adbc82c30f48dcf78dfec'
    @lc = Locu::Client.new(api_key)
  end

  def get_menu_item_data
    lc_result_hash  = @lc.menu.search_by({ :name => 'pizza',
                                           :price__lte => '100' })
    mi = MenuItem.new(lc_result_hash)
    mi.item_list_with(['id', 'name', 'price'])
  end
end
