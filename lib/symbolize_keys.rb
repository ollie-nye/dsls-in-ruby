# frozen_string_literal: true

class SymbolizeKeys < Operation
  requires :data, deep_symbolize: false

  def call
    symbolize_hash data
  end

  private

  def symbolize_hash(data)
    data = data.transform_keys(&:to_sym)

    return data unless deep_symbolize

    data.transform_values { |d| d.is_a?(Hash) ? symbolize_hash(d) : d }
  end
end
