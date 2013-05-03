$: << ::File.expand_path("../../lib", __FILE__)
require "recommendify"
require "redis"

# configure redis
Recommendify.redis = Redis.new

# our recommender class
class UserRecommender < Recommendify::Base

  #max_neighbors 50

  input_matrix :visits, 
    :similarity_func => :cosine
    # :native => true

end

recommender = UserRecommender.new
recommender.for "profile_23819"
# load some test data
# buckets = Hash.new{ |h,k| h[k]=[] }
# IO.read("example_data.csv").split("\n").each do |l|
#   user_id, item_id = l.split(",")
#   next if user_id.length == 0
#   buckets[user_id] << item_id
# end
# 
# # add the test data to the recommender
# buckets.each do |user_id, items|
#   puts "#{user_id} -> #{items.join(",")}"
#   items = items[0..99] # do not add more than 100 items per user
#   recommender.visits.add_set(user_id, items)
# end
# 
# recommender.process!
