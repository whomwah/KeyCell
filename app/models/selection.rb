class Selection < Array
  def lowest
    self.sort { |c1, c2| c1.index <=> c2.index }.first
  end

  def cells_below(cell, color=nil)
    if color
      self[0...index(cell)].select {|c| c.is_color?(color)}
    else
      self[0...index(cell)]
    end
  end
end