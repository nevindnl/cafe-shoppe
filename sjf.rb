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

def sjf input
  barista1 = Barista.new(1)
  barista2 = Barista.new(2)

  teas = []
  lattes = []
  affogatos = []

  output = []

  i = 0

  TIME.times do |t|
    while i < input.length and input[i]['order_time'] == t
      order = input[i]

      case order['type']
      when 'tea'
        teas.push(order)
      when 'latte'
        lattes.push(order)
      else
        affogatos.push(order)
      end

      i += 1
    end

    result1 = barista1.check(t, teas, lattes, affogatos)
    result2 = barista2.check(t, teas, lattes, affogatos)

    output.push(result1) if result1
    output.push(result2) if result2
  end

  output
end

output = sjf(input)
puts JSON.generate(output)
