require "ActorsClient/version"
require 'httparty'
require 'json'

module ActorsClient
  class Connection
    include HTTParty
    base_uri 'localhost:8000'

    def all
      response = JSON.parse(self.class.get("/").body)

      response.map do |item|
        Actor.new(item["Name"], item["Age"])
      end
    end

    def get(id)
      response = JSON.parse(self.class.get("/actors/#{id}").body)
      Actor.new(response["Name"], response["Age"])
    end

    def delete(id)
      response = self.class.delete("/actors/#{id}")
      response.code
    end

    def update(id, attributes)
      response = self.class.put("/actors/#{id}", body: JSON.generate(attributes))
      response.code
    end

    def create(attributes)
      response = self.class.post("/actors", body: JSON.generate(attributes))
      response.code
    end
  end

  class Actor
    attr_reader :name, :age

    def initialize(name, age)
      @name, @age = name, age
    end
  end
end
