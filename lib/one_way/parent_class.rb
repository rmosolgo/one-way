module OneWay::ParentClass
  def add_descendant(child_class)
    if !descendants.include?(child_class)
      descendants << child_class
    end
  end

  def descendants
    @descendants ||= []
  end

  def inherited(child_class)
    add_descendant(child_class)
  end
end
