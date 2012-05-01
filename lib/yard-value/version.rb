# -*- coding: utf-8 -*-

require 'inventory-1.0'

module YARDValue
  Version = Inventory.new(1, 2, 0){
    def dependencies
      super + Inventory::Dependencies.new{
        development 'inventory-rake', 1, 3, 0
        development 'lookout', 3, 0, 0
        development 'lookout-rake', 3, 0, 0
        runtime 'yard', 0, 8, 0, :feature => 'yard'
      }
    end
  }
end
