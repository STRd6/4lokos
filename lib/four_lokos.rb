#!/usr/bin/env ruby

require "4lokos/version"

require "heroku-api"
require "pry"

module FourLokos
  def self.heroku
    @heroku ||= Heroku::API.new(:api_key => ENV["API_KEY"])
  end

  # Your code goes here...
  def self.setup(app)
    prefix = "4LOKO_"

    config = Hash[*ENV.select do |key, value|
      key.start_with? prefix
    end.map do |key, value|
      [key.sub(prefix, ""), value]
    end.flatten]

    heroku.put_config_vars app, config
  end
end

heroku = FourLokos.heroku

pry
