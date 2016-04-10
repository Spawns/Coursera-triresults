class Event
  include Mongoid::Document
  field :o, as: :order, type: Integer
  field :n, as: :name, type: String
  field :d, as: :distance, type: Float
  field :u, as: :units, type: String

  embedded_in :parent, polymorphic: true, touch: true

  validates_presence_of :order, :name

  def meters
    if self.d
      case self.u
      when "meters" then self.d
      when "kilometers" then self.d * 1000
      when "yards" then self.d * 0.9144
      when "miles" then self.d * 1609.34
      end
    end
  end

  def miles
    if self.d
      case self.u
      when "meters" then self.d * 0.000621371
      when "kilometers" then self.d * 0.621371
      when "yards" then self.d * 0.000568182
      when "miles" then self.d
      end
    end
  end
end
