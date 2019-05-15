module Utils
  def format_param(request)
    request.params['format'].nil? ? [] : request.params['format'].split(',')
  end
end
