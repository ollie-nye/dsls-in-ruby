# frozen_string_literal: true

class MissingParameterError < StandardError; end

class StringifyKeys
  def initialize(**params)
    raise MissingParameterError, 'data' unless params.key?(:data)

    @data = params[:data]
    @deep_stringify = params[:deep_stringify] || false
  end

  def call
    stringify_hash_keys data
  end

  private

  attr_reader :data, :deep_stringify

  def stringify_hash_keys(data)
    data = data.transform_keys(&:to_sym)

    return data unless deep_stringify

    data.transform_values { |d| d.is_a?(Hash) ? stringify_hash_keys(d) : d }
  end
end
