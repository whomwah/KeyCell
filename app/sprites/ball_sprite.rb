class BallSprite < Joybox::Core::Sprite

  attr_accessor :index
  attr_reader :color

  @@sprites = SpriteFrameCache.frames.where prefix: 'color', suffix: '.png'

  def initialize
    @color = BOX_TYPES.sample

    super frame_name: "color_#{color}.png"
  end

  def self.create
    new
  end

  def pulse!
    run_action Sequence.with( actions:[
      Scale.to(scale:0.75),
      Scale.to(scale: 1.0)
    ])
  end

  def touched?(touch_location)
    rect = CGRect.new(boundingBox.origin, boundingBox.size)
    CGRectContainsPoint(rect, touch_location)
  end

  def match?(cell)
    color == cell.color unless cell.nil?
  end

  def is_color?(ccolor)
    color == ccolor
  end

  def change_color_to(color_string)
    @color = color_string
    switch_frame
  end

  def reset!
    @color = BOX_TYPES.sample
    switch_frame
  end

  def hide!
    @color = 'hidden'
    switch_frame
  end

  def move_to(cell, return_color=nil)
    old_position = position
    old_color    = color

    callback_action = Callback.with(object:cell) do |cell|
      cell.change_color_to(self.color)
      self.setPosition(old_position)
      self.change_color_to(return_color || old_color)
    end

    move_me = Move.to(position: cell.position)

    run_action Sequence.with(actions:[
      Scale.to(scale: 0.9, duration: 0.1),
      Scale.to(scale: 1.0, duration: 0.1),
      Ease.in(action: move_me, rate: 2),
      callback_action
    ])
  end

  private

  def switch_frame
    setDisplayFrame(SpriteFrameCache.frames["color_#{color}.png"])
  end

end