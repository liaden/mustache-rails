require 'action_view'
require 'mustache'
require 'action_view/mustache/context'

module ActionView
  # Public: Mustache View base class.
  #
  # All Mustache views MUST inherit from this class.
  #
  # Examples
  #
  #     module Layouts
  #       class Application < ActionView::Mustache; end
  #     end
  #
  class Mustache < ::Mustache
    # Internal: Initializes Mustache View.
    #
    # Initialization is handled by MustacheHelper#mustache_view.
    #
    # view - ActionView::Base instance
    #
    # Returns ActionView::Mustache instance.
    def initialize(view)
      # Reference to original ActionView context.
      @_view = view

      # Grab template path from view
      self.template_name = view.instance_variable_get(:@virtual_path)

      # If view has an associated controller
      if controller = view.controller
        # Copy controller ivars into our view
        controller.view_assigns.each do |name, value|
          instance_variable_set '@'+name, value
        end
      end

      # Define `yield` keyword for content_for :layout
      context[:yield] = lambda { content_for :layout }
    end

    def self.build(view, ivars = {})
      item = self.new view

      ivars.each do |key, value|
          item.instance_variable_set "@#{key}", value
      end

      item
    end

    # Remove Mustache's render method so ActionView's render can be
    # delegated to.
    undef_method :render

    # Public: Get view context.
    #
    # Returns ActionView::Mustache::Context instance.
    def context
      @context ||= Context.new(self)
    end

    # Public: Get cache key for current template contents.
    #
    # Useful for busting caches when the template changes.
    #
    # Returns 10 hex char String.
    def template_cache_key
      context[:template_cache_key]
    end

    # Public: Forwards methods to original Rails view context
    #
    # Returns an Object.
    def method_missing(*args, &block)
      @_view.send(*args, &block)
    end

    # Public: Checks if method exists in Rails view context.
    #
    # Returns Boolean.
    def respond_to?(method, include_private = false)
      super || @_view.respond_to?(method, include_private)
    end

  end
end
