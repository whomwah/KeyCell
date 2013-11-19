class MenuScene < Joybox::Core::Scene

  def on_enter
    background_layer = BackgroundLayer.new
    self << background_layer
    menu_layer = MenuLayer.new
    self << menu_layer
  end

end