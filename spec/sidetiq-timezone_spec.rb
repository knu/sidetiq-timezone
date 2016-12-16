require 'spec_helper'

# Disable logging
Sidetiq.logger = Logger.new(File.open(IO::NULL, 'w'))

describe SidetiqTimezone do
  before do
    ENV['TZ'], $TZ = 'America/New_York', ENV['TZ']
  end

  after do
    ENV['TZ'] = $TZ
  end

  it 'has a version number' do
    expect(SidetiqTimezone::VERSION).not_to be nil
  end

  describe 'Sidetiq.clock' do
    it 'responds to #time_zone/#time_zone=' do
      expect(Sidetiq.clock).to respond_to(:time_zone)
      expect(Sidetiq.clock).to respond_to(:time_zone=)
    end

    describe '#time_zone=' do
      before do
        @zone = ActiveSupport::TimeZone['Tokyo']
      end

      it 'accepts a time zone' do
        expect {
          Sidetiq.clock.time_zone = @zone
        }.not_to raise_error

        expect(Sidetiq.clock.time_zone).to equal @zone
      end

      it 'accepts nil' do
        expect {
          Sidetiq.clock.time_zone = nil
        }.not_to raise_error

        expect(Sidetiq.clock.time_zone).to be nil
      end
    end
  end

  describe 'with Workers' do
    before do
      Sidetiq.clock.time_zone = nil
      expect(Sidetiq.clock.time_zone).to be nil

      Time.zone = ActiveSupport::TimeZone['Tokyo']
      expect(Time.zone).not_to be nil

      @worker = Class.new do
        include Sidekiq::Worker
        include Sidetiq::Schedulable

        recurrence do
          daily.hour_of_day(10)
        end

        def perform
        end
      end
    end

    describe 'Sidetiq::Schedulable.time_zone' do
      it 'is set to Time.zone' do
        expect(@worker.time_zone).to equal Time.zone
      end
    end

    describe 'Sidetiq.clock.time_zone' do
      it 'is set to Time.zone' do
        expect(Sidetiq.clock.time_zone).to equal Time.zone
      end
    end

    describe 'schedule.next_occurrence' do
      let!(:now) { Time.zone.now }
      let!(:schedule_today) { now.change(hour: 10) }
      let!(:schedule_tomorrow) { now.tomorrow.change(hour: 10) }

      let!(:time_expectations) {
        [
          [schedule_today,    now.change(hour: 9)],
          [schedule_tomorrow, now.change(hour: 10)],
          [schedule_tomorrow, now.change(hour: 11)],
        ]
      }

      it 'conforms to the time zone' do
        time_expectations.each { |expected, time|
          expect(@worker.schedule.next_occurrence(time)).to eq(expected)
          expect(@worker.schedule.next_occurrence(time.to_time)).to eq(expected)
          expect(@worker.schedule.next_occurrence(time.to_time.utc)).to eq(expected)
        }
      end
    end
  end
end
