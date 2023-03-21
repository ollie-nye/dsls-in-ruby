# frozen_string_literal: true

require_relative 'spec_helper'

require_relative '../lib/symbolize_keys_raw'
require_relative '../lib/symbolize_keys_context'
require_relative '../lib/symbolize_keys'

RSpec.describe SymbolizeKeys do
  subject { described_class.call(**params) }

  context 'when no params are supplied' do
    let(:params) { {} }

    it 'raises MissingParameterError' do
      expect { subject }.to raise_error(MissingParameterError, 'data')
    end
  end

  context 'when a required param is missing' do
    let(:params) { { deep_symbolize: false } }

    it 'raises MissingParameterError' do
      expect { subject }.to raise_error(MissingParameterError, 'data')
    end
  end

  context 'when a default param is missing' do
    let(:params) { { data: { 'one' => 1, 'two' => { 'inner' => 'string', also: :symbols } } } }

    it 'completes successfully, using the default parameter' do
      expect(subject).to eq({ one: 1, two: { 'inner' => 'string', also: :symbols } })
    end
  end

  context 'when a default param is specified' do
    let(:params) { { data: { 'one' => 1, 'two' => { 'inner' => 'string', also: :symbols } }, deep_symbolize: true } }

    it 'overrides the default value and completes successfully' do
      expect(subject).to eq({ one: 1, two: { inner: 'string', also: :symbols } })
    end
  end
end
