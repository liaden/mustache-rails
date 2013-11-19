class HasPeopleObject < ActionView::Mustache
  def people
    KlassPartial.new(@_view)
  end
end
