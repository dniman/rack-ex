require './middleware/time_path.rb'
require './middleware/unlisted_formats.rb'
require './app.rb'

use TimePath
use UnlistedFormats
run App.new
