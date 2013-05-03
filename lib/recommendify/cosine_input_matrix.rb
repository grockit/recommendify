class Recommendify::CosineInputMatrix < Recommendify::InputMatrix
  include Recommendify::CCMatrix

  def initialize(opts={})
    super(opts)
  end

  def similarity(item1, item2)
    calculate_jaccard_cached(item1, item2)
  end

  def similarities_for(item1)
    (all_items - [item1]).map do |item2|
      [item2, similarity(item1, item2)]
    end
  end

  private

  def calculate_jaccard_cached(item1, item2)
    puts "********************************"
    val = ccmatrix[item1, item2]
    puts item1
    puts item2
    puts val
    puts item_count(item1)
    puts item_count(item2)
    val.to_f / (item_count(item1)+item_count(item2)-val).to_f
  end
  
  def redis_url
    Recommendify.redis.client.location
  end

  def redis_db
    Recommendify.redis.client.db
  end

end