class Sale < ActiveRecord::Base
  
  def self.active
    where("sales.starts_on <= ? AND sales.ends_on >= ?", 
    Date.current, Date.current)
  end

  def self.title
    title = Sale.find_by("sales.starts_on <= ? AND sales.ends_on >= ?", 
    Date.current, Date.current).name
  end

  def self.discount
    discount = Sale.find_by("sales.starts_on <= ? AND sales.ends_on >= ?", 
    Date.current, Date.current).percent_off
  end

  def finished?
    ends_on < Date.current
  end

  def upcoming?
    starts_on > Date.current
  end

  def active?
    !upcoming? && !finished?
  end

  validates :name, presence: true
  validates :percent_off, presence: true
  validates :starts_on, presence: true
  validates :ends_on, presence: true

end
