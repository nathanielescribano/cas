class Venue
  attr_accessor :data
  
  def initialize(string)
    @data = JSON.parse(string)
  end
 
  def self.test_string()
     <<eos
  {
    "meta": {
        "cache-expiry": 3600,
        "limit": 25
    },
    "objects": [
        {
            "categories": "['beauty salon']",
            "country": "United States",
            "cuisines": "['middle eastern']",
            "has_menu": true,
            "id": "83d902d79ee45fe7a658",
            "last_updated": "2012-08-22T00:30:49",
            "lat": 37.789057,
            "locality": "San Francisco",
            "long": -122.409201,
            "name": "Sutter Nails",
            "postal_code": "94102",
            "region": "CA",
            "resource_uri": "/v1_0/venue/83d902d79ee45fe7a658/",
            "street_address": "535 Sutter St.",
            "website_url": "http://www.sutternails.com/"
        }
    ]
  }
eos
  end

end
