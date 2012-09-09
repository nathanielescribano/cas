class MenuItem
  attr_accessor :data
  
  def initialize(hash)
    @data = hash
  end

  def find_venue_id_by_id(menu_item_id)
    return nil unless menu_item_id
    return nil unless !menu_item_id.empty?
    return nil unless @data["objects"]
    return nil unless @data["objects"].select { |o| o["id"] == menu_item_id }
    return nil unless @data["objects"].select { |o| o["id"] == menu_item_id }.first
    return nil unless @data["objects"].select { |o| o["id"] == menu_item_id }.first["venue"]
    return nil unless @data["objects"].select { |o| o["id"] == menu_item_id }.first["venue"]["id"]
    @data["objects"].select { |o| o["id"] == menu_item_id }.first["venue"]["id"]
  end

  def item_list
    item_list_with(["id","name"])
  end

  # keys accepts a array of key strings that can build the response array
  # i.e. keys = ["name","options","price"]
  # returns all items with the values for "name","options", and "price"
  # defaulted to ["name"],["id"]
  def item_list_with(keys = nil)
    return nil unless @data
    return nil unless @data["objects"]

    if keys == nil || keys == {}
      return @data["objects"].map do |object|
        [ "name" => o["name"], "id" => o["id"]]
      end
    end

    return @data["objects"].map do |object|
      object.delete_if do |object_key|
        !keys.include? object_key
      end
    end
  end
 
  def self.test_string()
     <<eos
  {
    "meta": {
        "cache-expiry": 3600
    },
    "not_found": [],
    "objects": [
        {
            "description": "",
            "id": "5975a83fe1d5be09b3c25904f7c9a75d76940f82bbfb39fb9db0ba29c23b0acf",
            "name": "Fried Wontons (8 in Order)",
            "options": "",
            "price": "3.5",
            "resource_uri": "/v1_0/menu_item/5975a83fe1d5be09b3c25904f7c9a75d76940f82bbfb39fb9db0ba29c23b0acf/",
            "venue": {
                "categories": "['restaurant']",
                "country": "United States",
                "id": "45ffb72973fae4a79fb5",
                "lat": 37.64609,
                "locality": "Modesto",
                "long": -120.993862,
                "name": "Minnie's Restaurant",
                "postal_code": "95354",
                "region": "CA",
                "street_address": "107 Mchenry Ave."
            }
        }
    ]
  }
eos
  end

end
