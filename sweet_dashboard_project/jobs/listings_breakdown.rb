SCHEDULER.every '2s' do
  stats = get_listings_stats
  data = stats.map{|k,v| [k, v]}

  send_event('listings_breakdown', {value: data})
end

def get_listings_stats
  response = Net::HTTP.get_response("localhost","/dashing/orders?format=json", 3000)
  JSON.parse(response.body)
end
