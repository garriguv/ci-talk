class Hockey
  attr_reader :token, :app_id

  def initialize(token, app_id)
    @token = token
    @app_id = app_id
  end
end
