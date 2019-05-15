class TimePath
  TIME_PATH_REGEX = /^\/time$/

  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    
    return @app.call env if path_matched?(request.path)

    [404, { 'Content-Type' => "text/plain" }, ["Bad request"]]
  end

  private

  def path_matched?(path)
    path.match? TIME_PATH_REGEX
  end
end
