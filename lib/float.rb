class Float
  def to_rational_string
    integer_component = to_i

    if integer_component != self
      fraction = (self - integer_component).to_r.to_s

      if integer_component > 0
        "#{integer_component} #{fraction}"
      elsif integer_component == 0
        "#{fraction}"
      end

    else
      integer_component.to_s
    end
  end

  def round_to_nearest_quarter
    (self / 0.25).round * 0.25
  end
end
