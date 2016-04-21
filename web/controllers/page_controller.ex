defmodule WeatherPhoenix.PageController do
	use WeatherPhoenix.Web, :controller

	def index(conn, _params) do
		render conn, "index.html"
	end

	def set_weather(conn, %{"get_location" => location}) do
		location = 
		location["location"]
		|> parse_location

		redirect(conn, to: "/weather/#{location}")
	end

	def get_weather(conn, %{"location" => location}) do
		weather = 
		location
		|> to_string
		|> get_location
		|> get_weather
		render(conn, "weather.html", weather: weather)
	end

	def parse_location(location) do
		String.replace(location, " ", "+")
	end	

	def get_location(address) do
		{status, list} = JSON.decode request_coordinates(address).body
		if status == :ok do
				results = list["results"] |> List.first
				latitude = results["geometry"]["location"]["lat"]
				longitude = results["geometry"]["location"]["lng"]
				"#{latitude},#{longitude}"
			else
				IO.puts "Error processing: #{status} code returned"
		end
	end

	def get_weather(location) do
		{status, list} = JSON.decode request_weather(location).body
		if status == :ok do
			currently(list)
		else
			IO.puts "Error: #{status} status returned"
		end
	end

	def currently(list) do
		list = list["currently"]
		trunc list["apparentTemperature"]
	end

	defp request_weather(location) do
		HTTPotion.get "#{forcast_io_full_url(location)}"
	end

	defp request_coordinates(address) do
		HTTPotion.get google_full_url(address)
	end

	defp google_full_url(address) do
		"https://maps.googleapis.com/maps/api/geocode/json?address=#{address}&key=AIzaSyDiglohQeePIsYHgHSLNqWeFhLg_xqxnV0"
	end

	defp forcast_io_full_url(location) do
		"https://api.forecast.io/forecast/80f71455dfe8a1e882ba6adf75b6ccf1/#{location}"
	end
end
