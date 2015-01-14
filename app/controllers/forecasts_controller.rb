require 'open-uri'
require 'json'

class ForecastsController < ApplicationController
  def display_form_to_user
  end

  def location
    @address = params[:address]

    url_safe_address = URI.encode(params[:address])

    url_of_location_data = "http://maps.googleapis.com/maps/api/geocode/json?address=" + "#{url_safe_address}"

    location_data = open(url_of_location_data).read

    parsed_location_data = JSON.parse(location_data)

    the_latitude = parsed_location_data["results"][0]["geometry"]["location"]["lat"]

    the_longitude = parsed_location_data["results"][0]["geometry"]["location"]["lng"]

    weather_url_coordinates = "https://api.forecast.io/forecast/59ea33818c0b4591622820cac6cbef25/" + "#{the_latitude},#{the_longitude}"

    raw_weather_data = open(weather_url_coordinates).read

    parsed_weather_data = JSON.parse(raw_weather_data)

    @forecast_results = parsed_weather_data

    render 'location'
  end
end
