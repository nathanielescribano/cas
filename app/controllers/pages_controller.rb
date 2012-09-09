class PagesController < ApplicationController
  protect_from_forgery
  include ApplicationHelper

  def index
    session[:max_price] ||= params[:max_price]
    session[:selected_items] ||= []

    # if params[:id] is nil - then it's likely the first
    # call - in which there are no selected_items
    if params[:id]
      session[:selected_items] << menu_item_data_from_param(params)
      @selected_items = session[:selected_items]
    end
  end

  def search
    @menu_item_data = []
    if params['menu_item'] && params['money_left']
      lc = get_locu_client
      @menu_item_data = menu_item_data(lc, params)
    end
    
  end

  def finalize
    @max_price = session[:max_price]
    @selected_items = session[:selected_items]

    # all the selected_items should point to the same
    # vendor. therefore, it doesn't matter which id
    # we use
    id = @selected_items.first['id']

    @vendor = find_vendor_by_menu_item_id id
  end

end
