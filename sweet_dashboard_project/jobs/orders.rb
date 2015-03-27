SCHEDULER.every '2s' do
  get_listings_stats.each do |k,v|
    send_event(k, { current: v})
  end
end

def get_listings_stats
  response = Net::HTTP.get_response("localhost","/dashing/orders?format=json", 3000)
  JSON.parse(response.body)
end
