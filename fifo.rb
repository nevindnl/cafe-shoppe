require 'io/console'
require 'json'
require_relative './barista'

TIME = 100
DRINKS = {
  'tea' => 3,
  'latte' => 4,
  'affogato' => 7
}

input_file = File.new("./input.json")
input = JSON.parse(input_file.read)

expected_output_file = File.new("./output_fifo.json")
expected_output = JSON.parse(expected_output_file.read)

def fifo input
  barista1 = Barista.new(1)
  barista2 = Barista.new(2)
  output = []

  input.each do |order|
    if barista1.next_available_time <= barista2.next_available_time
      result = barista1.assign(order)
    else
      result = barista2.assign(order)
    end

    break if result['start_time'] >= TIME
    output.push(result)
  end

  output
end

output = fifo(input)
puts JSON.generate(output)
