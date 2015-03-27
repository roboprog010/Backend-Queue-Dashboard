require 'net/http'
require 'uri'
@last_count = 0
SCHEDULER.every '10s' do |job|
  user_count = get_user_count
  send_event('user_count', current: user_count, last: @last_count)
  @last_count = user_count
end

def get_user_count
  response = Net::HTTP.get_response("localhost","/account/user_count?format=json", 3000)
  JSON.parse(response.body)["current_user_count"]
end
