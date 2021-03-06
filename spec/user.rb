class User < ActiveRecord::Base
  store_method :name

  def process(s)
    s * 2
  end

  def name(first_name = "John")
    process(first_name)
  end
end
