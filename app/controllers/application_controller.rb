class ApplicationController < ActionController::API

  def logged_in?
    !!current_user
  end

  def issue_token(payload)
    JWT.encode(payload, ENV["SECRET"])
  end

  def decode_token
    JWT.decode(get_token, ENV["SECRET"])[0]
  end

  def current_user
    decoded_hash = decode_token
    User.find(decoded_hash["user_id"])
  end

  def get_token
    request.headers["Authorization"]
  end

  def authorized
    render json: { error: "User not authorized" } unless logged_in?
  end

  def notify(act, entity)
    act = Act.create(
      actor:    current_user,
      entity:   entity,
      act_type: act
    )
  end
end
