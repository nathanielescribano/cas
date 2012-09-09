class PagesController < ApplicationController
  protect_from_forgery
  include ApplicationHelper

  def index
    @selected_items = session[:selected_items]
    if session[:max_price]
      @money_left = session[:max_price]
      @money_left = (@selected_items.reduce(@money_left.to_f) { |sum,v| sum - v[:price].to_f }).round(2).to_s
    else
      @money_left = nil
    end
  end

  def search
    @menu_item_data = []
    
    if params['menu_item'] && params['money_left']
      @search_value = params['menu_item']
      lc = get_locu_client

      @selected_items = session[:selected_items]
      if @selected_items
        si = @selected_items.first
        params.merge!({:lat => si[:lat], :long => si[:long]})
        
        @menu_item_data = sorted_menu_item_data_with_vendor(lc, params)
      else
        @menu_item_data = sorted_menu_item_data(lc, params)
      end

      @menu_item_data.each_index do |i|
        venue = @menu_item_data[i]["venue"]
        @menu_item_data[i]["lat"] = venue["lat"]
        @menu_item_data[i]["long"] = venue["long"]
        @menu_item_data[i].delete "venue"
      end
    end
    # we are limiting results for now..
    @menu_item_data = @menu_item_data[0..15]
    render :layout => false
  end

  def finalize
    @max_price = session[:max_price]
    @selected_items = session[:selected_items]

    # all the selected_items should point to the same
    # vendor. therefore, it doesn't matter which id
    # we use
    id = @selected_items.first[:id]
    
    @vendor = find_vendor_by_menu_item_id id
  end

  def add_to_cart
    session[:max_price] ||= params[:max_price]
    selected_items = session[:selected_items]

    session[:money_left] ||= params[:money_left]
    
    
    if params[:id]
      # if params[:id] is nil - then it's likely the first
      # call - in which there are no selected_items
      session[:selected_items] ||= []
      session[:selected_items] << menu_item_data_from_param(params)
      @selected_items = session[:selected_items]
    end

    redirect_to :action => "index"
  end

  def restart
    session[:max_price] = nil
    session[:money_left] = nil #should not occur
    session[:selected_items] = nil

    redirect_to :action => "index"
  end

end
