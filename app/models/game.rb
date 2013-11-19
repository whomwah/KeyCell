# @author Duncan Robertson
class Game
  attr_reader :game_grid, :cell_matches

  def initialize(game_layer)
    @game_layer   = WeakRef.new(game_layer)
    @game_grid    = GameGrid.new(@game_layer.sprite_batch)
    @cell_matches = Selection.new
  end

  def select(cell)
    @move_frozen = true

    game_grid.current_cell = cell
    recursive_cell_search(cell)

    until cell_matches.empty? do
      game_grid.animate(cell_matches)
    end

    @move_frozen = false
  end

  def reset!
    @cell_matches.clear
    game_grid.reset!
  end

  def detect_cell(touch_location)
    return if @move_frozen

    game_grid.find_cell_for_location(touch_location)
  end

  private

  def recursive_cell_search(cell)
    %w(up down left right).each {|p| send("look_#{p}", cell)}
    cell_matches << cell if !cell_matches.empty?
  end

  def look_up(cell)
    game_grid.above(cell).tap do |c|
      if can_add?(c)
        cell_matches << c

        look_up(c)
        look_left(c)
        look_right(c)
      end
    end
  end

  def look_down(cell)
    game_grid.below(cell).tap do |c|
      if can_add?(c)
        cell_matches << c

        look_down(c)
        look_left(c)
        look_right(c)
      end
    end
  end

  def look_left(cell)
    game_grid.left(cell).tap do |c|
      if can_add?(c)
        cell_matches << c

        look_left(c)
        look_up(c)
        look_down(c)
      end
    end
  end

  def look_right(cell)
    game_grid.right(cell).tap do |c|
      if can_add?(c)
        cell_matches << c

        look_right(c)
        look_up(c)
        look_down(c)
      end
    end
  end

  def can_add?(cell)
    game_grid.is_current_cell?(cell) && !cell_matches.include?(cell)
  end
end