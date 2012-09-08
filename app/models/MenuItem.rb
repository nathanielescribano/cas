class MenuItem
  attr_accessor :data
  
  def initialize(string)
    @data = JSON.parse(string)
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
