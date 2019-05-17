# app.rb
require './time_formatter'

class App

  def call(env)
    request = Rack::Request.new(env)
    time_fmt = TimeFormatter.new(request.params['format']) 
   
    if request.get? 
      case request.path
      when '/time'
        time_response(time_fmt)
      else
        not_found_response
      end
    else
      not_found_response
    end
  end

  private

  def time_response(formatter)
    if formatter.success_format?
      [200, { 'Content-Type' => 'text/plain' }, [formatter.formatted_time]]
    else
      [400, { 'Content-Type' => 'text/plain' }, ["Unknown time format [#{formatter.unknown_formats.join(',')}]"]]
    end
  end

  def not_found_response
    [404, { 'Content-Type' => 'text/plain' }, [ Rack::Utils::HTTP_STATUS_CODES[404] ]]
  end

end
