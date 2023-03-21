# frozen_string_literal: true

# Main thinking behind a context variable is to ease debugging. The running state of the whole call can be seen
# in one go, and could easily be extended to add more useful data to the same hash.

class MissingParameterError < StandardError; end

class SymbolizeKeysContext
  class << self
    # Or could define the same set of args and defaults here too, and pass them through manually
    def call(**params)
      new(**params).call
    end
  end

  # + Upfront about required args
  # - Unfriendly Ruby stacktrace on error
  # - Rubocop suggests only 5 arguments could be passed
  # def initialize(data:, deep_symbolize: false)
  #   @context = {
  #     data:,
  #     deep_symbolize:
  #   }
  # end

  # -- or --

  # + Friendlier stack trace on error
  # + Possibility for more data to be passed to a method in one go
  # - Harder to see at a glance what's required/optional and the structure of the data
  def initialize(**params)
    raise MissingParameterError, 'data' unless params.key?(:data)

    @context = {
      data: params[:data],
      deep_symbolize: params[:deep_symbolize] || false
    }
  end

  def call
    symbolize_hash data
  end

  private

  attr_reader :context

  def symbolize_hash(data)
    data = data.transform_keys(&:to_sym)

    return data unless deep_symbolize

    data.transform_values { |d| d.is_a?(Hash) ? symbolize_hash(d) : d }
  end

  # private private
  # mixes 'framework' of the class with logic, harder to separate

  def data
    context[:data]
  end

  def deep_symbolize
    context[:deep_symbolize]
  end
end
