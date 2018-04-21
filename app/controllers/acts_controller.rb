class ActsController < ApplicationController
  def feed
    acts = current_user.relevant_acts.map { |a| a.as_hash_with_body }
    render json: acts
  end
end
