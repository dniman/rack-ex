# time_formatter.rb
class TimeFormatter 

  FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  } 

  TEMPLATES = [
    'year-month-day hour:minute:second',
    'year-month-day hour:%M:second',
    'year-month-day %H:minute:second',
    'year-month-day %H:%M:second',
    'year-month-day %H:minute',
    'year-month-day hour:minute',
    'year-month-day hour:%M',
    'month-day hour:minute:second',
    'month-day hour:%M:second',
    'month-day %H:minute:second',
    'month-day %H:%M:second',
    'month-day %H:minute',
    'month-day hour:minute',
    'month-day hour:%M',
    'year-%m-day hour:minute:second',
    'year-%m-day hour:%M:second',
    'year-%m-day %H:minute:second',
    'year-%m-day %H:%M:second',
    'year-%m-day %H:minute',
    'year-%m-day hour:minute',
    'year-%m-day hour:%M',
    'year-month-%d hour:minute:second',
    'year-month-%d hour:%M:second',
    'year-month-%d %H:minute:second',
    'year-month-%d %H:%M:second',
    'year-month-%d %H:minute',
    'year-month-%d hour:minute',
    'year-month-%d hour:%M',
    'year-%m-%d hour:minute:second',
    'year-%m-%d hour:%M:second',
    'year-%m-%d %H:minute:second',
    'year-%m-%d %H:%M:second',
    'year-%m-%d %H:minute',
    'year-%m-%d hour:minute',
    'year-%m-%d hour:%M',
    'year-month-day',
    'year-%m-day',
    'month-day',
    'year-month',
    'hour:minute:second',
    'hour:%M:second',
    'minute:second',
    'hour:minute',
    'year',
    'month',
    'day',
    'hour',
    'minute',
    'second'
  ]
  
  attr_reader :formats

  def initialize(raw_format)
    @raw_format = raw_format
    @formats = @raw_format&.split(',') || []
  end

  def unknown_formats
    formats.inject([]) { |s,v| s << v unless FORMATS.keys.include?(v); s }
  end

  def success_format?
    unknown_formats.empty?
  end

  def formatted_time
    Time.now.strftime format
  end

  def format
    arr = []
    templates.each do |templ|
      arr << templ.dup
      FORMATS.keys.each do |fmt|
        arr.delete_if { |item| item.include? fmt }
      end
    end
    arr.first
  end

  def templates 
    arr = []
    TEMPLATES.each do |templ|
      arr << templ.dup
      formats.each do |fmt|
        arr.last.sub!(fmt, FORMATS[fmt])
      end
    end
    arr
  end

end
