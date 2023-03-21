# frozen_string_literal: true

class MissingParameterError < StandardError; end

class Operation
  class << self
    attr_reader :required_args, :default_args

    def inherited(base)
      super

      # These set a class instance variable, not an instance instance variable.
      # Every instance of the class will have access to these
      base.instance_variable_set(:@required_args, [])
      base.instance_variable_set(:@default_args, {})
    end

    def call(**context) = new(**context).call

    private

    def requires(*args, **default_args)
      @required_args = args + default_args.keys
      @default_args = default_args
    end
  end

  def initialize(**context)
    @context = prepare_args(context)
    validate_context

    # puts "Operation context is: #{@context}"
  end

  def call
    raise NotImplementedError
  end

  private

  attr_reader :context

  # build context

  def prepare_args(args)
    sanitized_args = args.slice(*self.class.required_args)
    self.class.default_args.dup.merge(**sanitized_args)
  end

  def validate_context
    missing_args = self.class.required_args - context.keys
    raise MissingParameterError, missing_args.join(', ') if missing_args.any?
  end

  # replaces accessor methods

  def respond_to_missing?(name, *args, **kwargs)
    context.key?(name) ? true : super
  end

  def method_missing(name, *args, **kwargs)
    context.key?(name) ? context[name] : super
  end
end
