class Cat < ApplicationRecord

  COLORS = ['blue', 'red', 'green', 'grey',
            'brown', 'black', 'white', 'vocanic orange',
            'winestain', 'charcoal', 'shiny']

  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: { in: COLORS, message: 'invalid color'}
  def age
    (Date.today - self.birth_date).to_i
  end

  def self.colors
    COLORS
  end

end
