class UpTimeRobot < WatchDog
  STATUS = {
    '0' => 'paused',
    '1' => 'not checked yet',
    '2' => 'up',
    '8' => 'seems down',
    '9' => 'down'
  }


  def watch
    response = HTTParty.get(url, headers: { 'Content-Type' => 'application/json' })
    if response.success?
      response.parsed_response['monitors']['monitor'].map do |app|
        {
          name: app['friendlyname'],
          status: STATUS[app['status'].to_s]
        }
      end
    else
      []
    end
  end

  def url
    "https://api.uptimerobot.com/getMonitors?apiKey=#{api_key}"
  end
end
