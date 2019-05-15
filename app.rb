# app.rb
require './utils'

class App
  include Utils

  def call(env)
    request = Rack::Request.new(env)
    
    if request.get? 
      [200, { 'Content-Type' => 'text/plain' }, [formatted_time(request)]]
    end
  end

  private

  def template
    @template ||= []
  end

  def format_template(formats)
    template << "%F" if formats.include?("year") && formats.include?("month") && formats.include?("day")
    template << "%T" if formats.include?("hour") && formats.include?("minute") && formats.include?("second")
    template.join(' ')
  end

  def formatted_time(request)
    Time.now.strftime format_template(format_param(request))
  end
end
