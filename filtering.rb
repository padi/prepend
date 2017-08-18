# rubocop:disable all
module Filtering
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def before_action(method)
      before_actions << method
    end

    def before_actions
      @before_actions ||= []
    end

    def after_action(method)
      after_actions << method
    end

    def after_actions
      @after_actions ||= []
    end
  end

  def process
    self.class.before_actions.each { |method| send method }
    super # does ActionController::Base.process
    self.class.after_actions.each { |method| send method }
  end
end

