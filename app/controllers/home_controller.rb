require "redis"

class HomeController < ApplicationController
  def index
    @announcement = Redis.new(url: ENV.fetch("REDIS_URL")).get("announcements")
  end
end
