# -*- coding: utf-8 -*-

require 'inventory/rake-1.0'
require 'lookout/rake-3.0'

load File.expand_path('../lib/value/yard/version.rb', __FILE__)

Inventory::Rake::Tasks.define Value::YARD::Version, :gem => proc{ |_, s|
  s.author = 'Nikolai Weibull'
  s.email = 'now@bitwi.se'
  s.homepage = 'https://github.com/now/value-yard'
}

# TODO: Silence warnings generated from YARD (remove this once we plug them)
Lookout::Rake::Tasks::Test.new :options => []