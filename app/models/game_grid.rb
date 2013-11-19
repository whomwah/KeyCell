class GameGrid
  attr_reader :cells
  attr_accessor :current_cell

  def initialize(sprite_batch)
    @sprite_batch = WeakRef.new(sprite_batch)
    @cells = build_grid
  end

  def above(cell, cnt=1)
    cells[cell.index+(GAME_GRID_COLS*cnt)]
  end

  def below(cell, cnt=1)
    if cell.index-(GAME_GRID_COLS*cnt) > 0
      cells[cell.index-(GAME_GRID_COLS*cnt)]
    end
  end

  def left(cell, cnt=1)
    if cell.index % (GAME_GRID_COLS*cnt) != 0
      cells[cell.index-1]
    end
  end

  def right(cell, cnt=1)
    if cell.index % (GAME_GRID_COLS*cnt) != ((GAME_GRID_COLS*cnt)-1)
      cells[cell.index+1]
    end
  end

  def is_current_cell?(cell)
    current_cell && current_cell.match?(cell)
  end

  def find_cell_for_location(touch_location)
    cells.detect { |t| t.touched?(touch_location) }
  end

  def reset!
    cells.map { |cell| cell.reset! }
  end

  def animate(cell_matches)
    return [] if cell_matches.empty?

    cell = cell_matches.lowest
    all = Selection.new.tap do |ary|
      ary << cell
      look_up(cell, cell_matches, ary)
    end

    all.each_with_index do |c, i|
      if cell_matches.include?(c)
        c.hide!
      else
        total_b = all[0..i].select {|s| s.match?(cell) && cell_matches.include?(s)}.size

        returnc = all[i + total_b]
        clr = returnc ? returnc.color : 'hidden'

        c.move_to(all[i - total_b], clr)
      end
    end

    all.each {|c| cell_matches.delete(c)}
  end

  private

  def look_up(cell, cell_matches, ary)
    above(cell).tap do |c|
      unless c.nil?
        ary << c
        look_up(c, cell_matches, ary)
      end
    end
  end

  def build_grid
    count = 0
    edgex = ((Device.screen.width -  (GAME_GRID_COLS*SPACER)) / 2) + KOFFSETX
    edgey = ((Device.screen.height - (GAME_GRID_ROWS*SPACER)) / 2) + KOFFSETY

    GAME_GRID_ROWS.times.map do |row|
      GAME_GRID_COLS.times.map do |col|
        BallSprite.create.tap do |cell|
          cell.setPosition([
            (col*SPACER) + edgex + (SPACER/2),
            (row*SPACER) + edgey
          ])
          cell.index = count
          count += 1

          @sprite_batch << cell
        end
      end
    end.flatten
  end
end