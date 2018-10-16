class Knight
  def self.moves(start, finish_code)
    @board = Board.new
    queue = [@board.squares.find { |square| square.code == start }]
    
    queue.each do |current_position|
      return current_position.path if current_position.code == finish_code
      possible_steps = [[-2,1],[-1,2],[1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1]]
        .map { |moves| [current_position.code[0] + moves[0], current_position.code[1] + moves[1]] }
        .select { |step_code| queue.none? { |element| element.code == step_code }}
        .map { |step_code| @board.squares.find { |square| square.code == step_code }}
        .compact
      possible_steps.each { |square| square.parent = current_position }
      queue.concat(possible_steps)
    end
  end
end

class Square
  attr_accessor :code, :parent

  def initialize code
    @code = code
    @parent = nil
  end
  def path
    path = []
    current = self
    loop do
      path.unshift(current.code)
      break if current.parent.nil?
      current = current.parent
    end
    path
  end
end

class Board
  attr_reader :squares

  def initialize
    @squares = []
    8.times do |x|
      8.times do |y|
        @squares << Square.new([x, y])
      end
    end
  end
end

p Knight.moves([0,0],[3,3])
p Knight.moves([3,3],[0,0])
