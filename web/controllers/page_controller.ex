defmodule WeatherPhoenix.PageController do
	use WeatherPhoenix.Web, :controller

	def index(conn, _params) do
	render conn, "index.html"
	end

	def geocode(conn, %{"address" => address}) do
		address
		|> parse_address
		|> 
	end

	def weather(conn, %{"id" => id}) do
		render conn, "weather.html", id: id
	end

	def parse_address(address) do
		String.replace(address, " ", "+")
	end	

	# Hits the forecast.io api
	def request_weather(location) do
		HTTPotion.get "#{forcast_io_full_url(location)}"
	end

	# Hits the Google Maps API 
	def request_coordinates(address) do
		HTTPotion.get google_full_url(address)
	end

	def google_full_url(address) do
		"https://maps.googleapis.com/maps/api/geocode/json?address=#{address}&key=#{google_api_key}"
	end

	def forcast_io_full_url(location) do
		"https://api.forecast.io/forecast/#{forcast_io_api_key}/#{location}"
	end

	defp forcast_io_api_key do
		"80f71455dfe8a1e882ba6adf75b6ccf1"
	end

	defp google_api_key do
		"AIzaSyDiglohQeePIsYHgHSLNqWeFhLg_xqxnV0"
	end
end
