class Barista
  attr_reader :id
  attr_accessor :next_available_time
  def initialize id
    @id = id
    @next_available_time = 0
  end

  def assign order
    order_id = order['order_id']
    order_time = order['order_time']
    type = order['type']

    result = {}
    result['order_id'] = order_id
    result['start_time'] = [@next_available_time, order_time].max
    result['barista_id'] = @id

    @next_available_time = result['start_time'] + DRINKS[type]
    result
  end

  def check time, teas, lattes, affogatos
    return false if time < @next_available_time

    result = false

    if !teas.empty?
      result = assign(teas.shift)
    elsif !lattes.empty?
      result = assign(lattes.shift)
    elsif !affogatos.empty?
      result = assign(affogatos.shift)
    end

    result
  end
end
