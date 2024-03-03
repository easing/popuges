##
class DoorkeeperStrategy < OmniAuth::Strategies::OAuth2
  option :name, :doorkeeper

  option :client_options,
         site: ENV["DOORKEEPER_APP_URL"],
         authorize_path: "/oauth/authorize"

  uid { raw_info["resource_owner_id"] }

  def raw_info
    @raw_info ||= access_token.get('/oauth/token/info.json').parsed
  end

  # https://github.com/intridea/omniauth-oauth2/issues/81
  def callback_url
    full_host + script_name + callback_path
  end
end
