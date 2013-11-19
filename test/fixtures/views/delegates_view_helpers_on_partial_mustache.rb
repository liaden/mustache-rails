class DelegatesViewHelpersOnPartialMustache < ActionView::Mustache
  def delegate
    DelegatedPartial.new(@_view)
  end
end

