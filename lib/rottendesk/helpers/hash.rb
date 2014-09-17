class Hash
  def compact
    select do |_, v|
      !v.nil?
    end
  end

  def except(*keys)
    dup.except!(*keys)
  end

  def except!(*keys)
    keys.each { |key| delete(key) }
    self
  end
end
