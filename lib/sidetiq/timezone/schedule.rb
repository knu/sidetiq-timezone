# :markup: markdown

module Sidetiq
  module Timezone
    module Schedule
      # Makes start_time adopt the application time zone.
      module ClassMethods
        def start_time
          start_time = super
          if time_zone = Sidetiq.clock.time_zone
            time_zone.local(start_time.year, start_time.month, start_time.day)
          else
            start_time
          end
        end
      end
    end
  end

  class Schedule
    class << self
      prepend Timezone::Schedule::ClassMethods
    end
  end
end
