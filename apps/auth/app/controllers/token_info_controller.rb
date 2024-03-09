class TokenInfoController < Doorkeeper::TokenInfoController
  protected

  def doorkeeper_token_to_json
    user = User.find(doorkeeper_token.resource_owner_id)
    super.as_json.merge(user: user.as_json)
  end
end