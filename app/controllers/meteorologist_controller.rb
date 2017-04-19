require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================
    streets_no_spaces=@street_address.gsub(" ","+")

    url="http://maps.googleapis.com/maps/api/geocode/json?address= ".gsub(" ",streets_no_spaces)
    parsed_data = JSON.parse(open(url).read)
    @lat = parsed_data["results"][0]["geometry"]["location"]["lat"]
    @lng = parsed_data["results"][0]["geometry"]["location"]["lng"]


    url2="https://api.darksky.net/forecast/ba60958707ecdd9067f031f506afc632/#{@lat},#{@lng}"
    parsed_data = JSON.parse(open(url2).read)

    @current_temperature =parsed_data["currently"]["temperature"]

    @current_summary =parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
