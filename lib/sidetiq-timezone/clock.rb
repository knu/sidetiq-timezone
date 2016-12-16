# :markup: markdown

module SidetiqTimezone
  # Adds an accessor `time_zone`.
  module Clock
    attr_accessor :time_zone

    def time_zone=(time_zone)
      info "Using the time zone: #{time_zone ? time_zone.name : 'none'}"
      @time_zone = time_zone
    end

    def gettime
      if @time_zone
        @time_zone.now
      else
        super
      end
    end
  end
end

class Sidetiq::Clock
  prepend SidetiqTimezone::Clock

  ##
  # :attr_accessor: time_zone
  #
  # Time zone for Sidetiq.  If you don't set this, it is
  # automatically set to `Time.zone` when the first class to include
  # `Sidetiq::Schedulable` is defined.
  #
  # ```ruby
  # Sidetiq.clock.time_zone = ActiveSupport::TimeZone['Tokyo']
  # ```
end
