# -*- coding: utf-8 -*-

require 'inventory-1.0'

module Value end

module Value::YARD
  Version = Inventory.new(1, 1, 0){
    def dependencies
      super + Inventory::Dependencies.new{
        development 'inventory-rake', 1, 2, 0
        development 'lookout', 3, 0, 0
        development 'lookout-rake', 3, 0, 0
        optional 'yard', 0, 7, 0
      }
    end

    def requires
      %w'
        yard
      '
    end
  }
end
