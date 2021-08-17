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

20.times do
  n = rand(sr.number_pins)
  sr.write_pin n, 1
  sleep pause
  sr.write_pin n, 0
  sleep pause
end

# 10.times do
#   sr.write_array array
#   sleep pause
#   array.shift
#   case array.last
#   when 1
#     array.append 0
#   when 0
#     array.append 1
#   end
# end

sr.all_off

RPi::GPIO.clean_up
