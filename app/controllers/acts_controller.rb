class ActsController < ApplicationController
  def feed
    render json: Act.hash_with_bodies
  end
end
