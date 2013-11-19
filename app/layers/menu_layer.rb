class MenuLayer < Joybox::Core::Layer

  def on_enter
    self << layout_menu
  end

  def layout_menu
    MenuLabel.default_font_name = 'Helvetica'

    items = Array.new
    menu_items.each do |k,v|
      items << MenuLabel.new(text: k) do |menu_item|
        game_scene = GameScene.new
        director.push_scene game_scene
      end
    end

    menu = Menu.new(
      position: Screen.center,
      items: items
    )
    menu.align_items_vertically
    menu
  end

  private

  def menu_items
    {
      "New Game" => "1"
    }
  end

end