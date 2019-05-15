require './utils'

class UnlistedFormats
  include Utils

  FORMATS = %w[year month day hour minute second]

  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)

    return @app.call env if unlisted_formats(request).empty?
  
    [400, { 'Content-Type' => "text/plain" }, ["Unknown time format [#{unlisted_formats.join(',')}"]]
  end

  def unlisted_formats(request)
    formats = format_param(request)
    formats.inject([]) { |s, v| s << v unless FORMATS.include?(v); s }
  end

end
