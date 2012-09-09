class PagesController < ActionController::Base
  protect_from_forgery

  def index
  end
  
  def search
    @menu_item_data = []
    @menu_item_data << {:id => "1", :name =>"Sushi", :price => "$1.00"}
    @menu_item_data << {:id => "2", :name =>"Beer" ,:price => "$2.00"}
    @menu_item_data << {:id => "3", :name =>"Pizza",:price => "$3.00"}
  end
end
