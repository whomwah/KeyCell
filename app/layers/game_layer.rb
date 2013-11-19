class GameLayer < Joybox::Core::Layer

  attr_reader :game, :sprite_batch

  def on_enter
    setup_labels
    setup_game
    handle_touches
  end

  def setup_game
    SpriteFrameCache.frames.add file_name: 'sprites.plist'
    @sprite_batch = SpriteBatch.new file_name: "sprites.png"
    self << sprite_batch
    @game = Game.new(self)
  end

  def setup_labels
    label = MenuLabel.new(
      text: "Reset Game",
      font_size: 22
      ) { |label| @game.reset! }

    menu = Menu.new(
      position: [Screen.half_width, Screen.height - 50],
      items: [label]
    )
    menu.align_items_vertically
    self << menu
  end

  def handle_touches
    on_touches_began do |touches, event|
      touch = touches.any_object

      if cell = game.detect_cell(touch.location)
        game.select(cell)
      end
    end
  end
end