class MenuLayer < Joybox::Core::Layer

  def on_enter
    on_touches_began do |touches, event|
      touch = touches.any_object
      puts "The touch location is: #{touch.location}"
    end


    background_sprite = Sprite.new(
      file_name: 'sprites/menu/background.png',
      position: Screen.center
    )

    self << background_sprite
    self << layout_menu
  end

  def layout_menu
    MenuLabel.default_font_name = 'Helvetica'

    items = Array.new
    menu_items.each do |k,v|
      items << MenuLabel.new(text: k) do |menu_item|
        p "You clicked #{v}"
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
      "New Game" => "1",
      "Settings" => "2",
      "Instructions" => "3"
    }
  end

end