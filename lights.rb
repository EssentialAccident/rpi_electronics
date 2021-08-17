# Outside libraries
require 'rpi_gpio'

# My libraries
require_relative 'lib/sr74hc595'

RPi::GPIO.set_numbering :bcm

data_pin = 16
clock_pin = 20
latch_pin = 21
pause = 0.1

array = [1, 0, 1, 0, 1, 0, 1, 0]

sr = RPiElectronics::SR74hc595.new data_pin, clock_pin, latch_pin

# sr.write_array array

sr.number_pins.times do |pin|
  sr.write_pin pin, 1
  sleep pause
end

(sr.number_pins - 1).downto(0) do |pin|
  sr.write_pin pin, 0
  sleep pause
end

sr.all_off

RPi::GPIO.clean_up
