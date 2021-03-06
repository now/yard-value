# -*- coding: utf-8 -*-

require 'inventory-1.0'

module YARDValue
  Version = Inventory.new(1, 2, 5){
    authors{
      author 'Nikolai Weibull', 'now@disu.se'
    }

    homepage 'http://disu.se/software/yard-value-1.0/'

    licenses{
      license 'LGPLv3+',
              'GNU Lesser General Public License, version 3 or later',
              'http://www.gnu.org/licenses/'
    }

    def dependencies
      super + Inventory::Dependencies.new{
        development 'inventory-rake', 1, 6, 0
        development 'lookout', 3, 0, 0
        development 'lookout-rake', 3, 1, 0
        runtime 'yard', 0, 8, 7, :feature => 'yard'
      }
    end
  }
end
