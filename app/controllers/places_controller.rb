class PlacesController < ApplicationController

require 'rubygems'

include GeoKit::Geocoders
include Ym4r::GmPlugin  

  def MapRequest
  end

  def MapOfPlace
	new_location = params[:location]
#	gg = GeoKit::Geocoders::google="ABQIAAAAP-fyuCO1gtYu5_3lXP6U6BTJQa0g3IQ9GZqIMmInSLzwtGDKaBTHyOezB1aqugy-ZUVi7wFfE83gWg"
	gg = GeoKit::Geocoders::google
	gg_locate = GeoKit::Geocoders::MultiGeocoder.geocode(new_location)
	coordinates = [gg_locate.lat, gg_locate.lng]
	@map = GMap.new("map")
	@map.control_init(:large_map => true, :map_type => true)
	@map.center_zoom_init(coordinates,10)
	@map.overlay_init(GMarker.new(coordinates, :title => new_location, :info_window =>new_location))
  end

end

