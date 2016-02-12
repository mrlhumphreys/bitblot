class Group
  def initialize
    @squares = [{x: 0, y: 0}]
  end
  
  attr_reader :squares
  
  def add_random_square!
    @squares.push(random_surrounding_square)
  end
  
  def grid_data
    range_y.map do |y| 
      range_x.map do |x| 
        @squares.any? { |s| s[:x] == x && s[:y] == y } ? 1 : 0
      end
    end
  end
  
  def blot_data
    range_y.map do |y| 
      range_x.concat(range_x.reverse).map do |x| 
        @squares.any? { |s| s[:x] == x && s[:y] == y } ? 1 : 0
      end
    end
  end
  
  def print(data)
    data.each do |row|
      line = row.map do |column|
        column == 1 ? '█' : ' '
      end.join('')
      puts line
    end
  end
  
  def print_grid
    print grid_data
  end
  
  def print_blot
    print blot_data
  end

  private
  
  def range_y
    (min_y..max_y).to_a
  end
  
  def range_x
    (min_x..max_x).to_a
  end
  
  def min_x
    @squares.map { |s| s[:x] }.min
  end
  
  def min_y
    @squares.map { |s| s[:y] }.min
  end
  
  def max_x
    @squares.map { |s| s[:x] }.max
  end
  
  def max_y
    @squares.map { |s| s[:y] }.max
  end
  
  def surrounding_squares
    @squares.map do |s|
      [ {x: s[:x]+1, y: s[:y]},
        {x: s[:x], y: s[:y]+1},
        {x: s[:x]-1, y: s[:y]},
        {x: s[:x], y: s[:y]-1}
      ]
    end.flatten.uniq - @squares 
  end
  
  def random_surrounding_square
    surrounding_squares[Random.new.rand(surrounding_squares.size)]
  end
end

group = Group.new

256.times do 
  group.add_random_square!
end

group.print_blot
