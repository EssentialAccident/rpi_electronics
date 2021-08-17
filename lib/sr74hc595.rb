# frozen_string_literal: true

require 'rpi_gpio'

module RPiElectronics
  # The SR74hc595 is a class to operate the 74hc595 shift register
  # It allows to cascade or daisy chain as many shift registers as needed
  # This class assumes that the user has set the mode of the board already
  class SR74hc595
    # Constants
    PAUSE = 0.5

    def initialize(data_pin, clock_pin, latch_pin, number_chips = 1)
      @data_pin = data_pin
      @clock_pin = clock_pin
      @latch_pin = latch_pin
      @number_chips = number_chips
      setup
    end

    def write_array(data)
      RPi::GPIO.set_low @latch_pin
      data.each do |bit|
        case bit
        when 0
          RPi::GPIO.set_low @data_pin
        when 1
          RPi::GPIO.set_high @data_pin
        end
        tick
      end
      RPi::GPIO.set_high @latch_pin
    end

    def all_off
      array = []
      (8 * @number_chips).times { array.append 0 }
      write_array array
    end

    def all_on
      array = []
      (8 * @number_chips).times { array.append 1 }
      write_array array
    end

    def tick
      RPi::GPIO.set_high @clock_pin
      # It is possible to add some kind of pause here
      RPi::GPIO.set_low @clock_pin
    end

    def setup
      RPi::GPIO.setup @data_pin, as: :output, initialize: :low
      RPi::GPIO.setup @clock_pin, as: :output, initialize: :low
      RPi::GPIO.setup @latch_pin, as: :output, initialize: :high
    end
  end
end
