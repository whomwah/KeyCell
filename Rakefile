# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bundler'
Bundler.require

require 'bubble-wrap/core'
require 'matrix'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Keycell'
  app.identifier = 'com.whomwah'
  app.device_family = [:iphone]
  app.interface_orientations = [:portrait]
  app.icons = ['Icon-80.png', 'Icon-120.png', 'Icon@2x.png']
  app.prerendered_icon = true
  app.files << Dir.glob("./config/*.rb")

  app.info_plist['UIViewControllerBasedStatusBarAppearance'] = false
end
