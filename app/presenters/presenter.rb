class Presenter
  attr_accessor :presentable, :view_context

  def initialize(atts={})
    @view_context = atts[:view_context]
    after_initialize(atts)
  end

  def title
    fail NotImplementedError, "All presenters must implement the 'title' method"
  end

  private

  def after_initialize(atts)
    #override in subclasses
  end

  def method_missing(*args, &block)
    presentable.send(*args, &block) rescue view_context.send(*args, &block) #send all unknown methods to view_context
  end
end
