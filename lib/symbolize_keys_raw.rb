# frozen_string_literal: true

class MissingParameterError < StandardError; end

class SymbolizeKeysRaw
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
  #   @data = data
  #   @deep_symbolize = deep_symbolize
  # end

  # -- or --

  # + Friendlier stack trace on error
  # + Possibility for more data to be passed to a method in one go
  # - Harder to see at a glance what's required/optional and the structure of the data (if the arguments list grows)
  def initialize(**params)
    raise MissingParameterError, 'data' unless params.key?(:data)

    @data = params[:data]
    @deep_symbolize = params[:deep_symbolize] || false
  end

  def call
    symbolize_hash_keys data
  end

  private

  attr_reader :data, :deep_symbolize

  def symbolize_hash_keys(data)
    data = data.transform_keys(&:to_sym)

    return data unless deep_symbolize

    data.transform_values { |d| d.is_a?(Hash) ? symbolize_hash_keys(d) : d }
  end
end
