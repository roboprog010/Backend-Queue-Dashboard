# send_event('mychart', slices: [
#   ['Task', 'Hours per Day'],
#   ['Work',     11],
#   ['Eat',      2],
#   ['Commute',  2],
#   ['Watch TV', 2],
#   ['Sleep',    7]
# ])
SCHEDULER.every '2s' do
  stats = get_listings_stats
  data = stats.map{|k,v| [k, v.to_i]}
  data = [["type", "amount"]] + data
  STDERR.puts "#{data}"
  send_event('mychart', slices: data)
end

def get_listings_stats
  response = Net::HTTP.get_response("localhost","/dashing/orders?format=json", 3000)
  JSON.parse(response.body)
end
