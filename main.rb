class Square
  def initialize(x, y)
    @x, @y = x, y
  end
  
  attr_reader :x, :y
  
  def surrounding_squares
    [ Square.new(@x+1, @y),
      Square.new(@x, @y+1),
      Square.new(@x-1, @y),
      Square.new(@x, @y-1)
    ]
  end
  
  def ==(other)
    @x == other.x && @y == other.y
  end
  
  def eql?(other)
    @x == other.x && @y == other.y
  end
  
  def hash
    "#{self.class},#{@x},#{@y}".hash
  end
  
  private
end

class Group
  def initialize
    @squares = [Square.new(0,0)]
  end
  
  attr_reader :squares
  
  def add_random_square!
    @squares.push(random_surrounding_square)
  end
  
  def grid_data
    range_y.map do |y| 
      range_x.map do |x| 
        @squares.any? { |s| s.x == x && s.y == y } ? 1 : 0
      end
    end
  end
  
  def blot_data
    range_y.map do |y| 
      range_x.concat(range_x.reverse).map do |x| 
        @squares.any? { |s| s.x == x && s.y == y } ? 1 : 0
      end
    end
  end
  
  def print(data)
    data.each do |row|
      line = row.map do |column|
        column == 1 ? '#' : ' '
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
    @squares.map(&:x).min
  end
  
  def min_y
    @squares.map(&:y).min
  end
  
  def max_x
    @squares.map(&:x).max
  end
  
  def max_y
    @squares.map(&:y).max
  end
  
  def surrounding_squares
    @squares.map(&:surrounding_squares).flatten.uniq - @squares
  end
  
  def random_surrounding_square
    surrounding_squares[Random.new.rand(surrounding_squares.size)]
  end
end

group = Group.new

128.times do 
  group.add_random_square!
end

group.print_blot
