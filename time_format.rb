class TimeFormat
  FORMATS = {
    'year' => :year,
    'month' => :month,
    'day' => :day,
    'hour' => :hour,
    'minute' => :min,
    'second' => :sec
  }.freeze

  def initialize(request)
    request.params['format'].split(',')
    @requested_format = request.params['format'].split(',')
  end

  def by_format
    if invalid_format?
      "Unknown time format [#{invalid_formats.join(', ')}]\n"
    else
      time = Time.now
      @requested_format.map { |r_format| time.send(FORMATS[r_format]) }.join('-') + "\n"
    end
  end

  def invalid_formats
    invalid_format = []
    @requested_format.uniq.each do |format|
      invalid_format << format unless FORMATS.has_key?(format)
    end
    invalid_format
  end

  def invalid_format?
    invalid_formats.any?
  end
end

