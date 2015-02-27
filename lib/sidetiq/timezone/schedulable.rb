# :markup: markdown

module Sidetiq
  module Timezone
    module Schedulable
      # Automatically sets the application time zone for Sidetiq when
      # a (first) worker is defined.
      module ClassMethods
        def included(klass)
          super
          Sidetiq.clock.time_zone ||= Time.zone
        end
      end
    end
  end

  module Schedulable
    class << self
      prepend Timezone::Schedulable::ClassMethods
    end

    module ClassMethods
      # Returns Sidetiq.clock.time_zone.
      def time_zone
        Sidetiq.clock.time_zone
      end
    end
  end
end
