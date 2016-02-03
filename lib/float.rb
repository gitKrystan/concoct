class Float
  def to_rational_string
    integer_component = to_i
    if (integer_component != self) && (integer_component > 0)
      fraction = (self - integer_component).to_r
      "#{integer_component} #{fraction}"
    else
      integer_component.to_s
    end
  end
end
