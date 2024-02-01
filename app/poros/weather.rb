class Weather
  attr_reader :date,
              :current_temp,
              :max_temp,
              :min_temp,
              :summary

  def initialize(data)
    @date = Time.at(data[:dt]).strftime("%A, %B %d, %Y")
    # without .zone gives UTC time
    @current_temp = data[:main][:temp]
    @max_temp = data[:main][:temp_max]
    @min_temp = data[:main][:temp_min]
    @summary = data[:weather].first[:description]
  end
end
