class String
  def countize(number)
    "#{number} #{number.to_i == 1 ? self : self.pluralize}"
  end
end
