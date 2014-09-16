class Hash
  def compact
    select do |_, v|
      !v.nil?
    end
  end
end
