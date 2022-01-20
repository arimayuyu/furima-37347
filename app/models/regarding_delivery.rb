class RegardingDelivery < ActiveHash::Base
  self.data = [
    { id: 0, name: '---' },
    { id: 1, name: '1日〜２日で発送' },
    { id: 2, name: '２日〜３日で発送' },
    { id: 3, name: '４日〜７日で発送' }

  ]
end