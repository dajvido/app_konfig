require 'spec_helper'
require 'app_konfig/config'

RSpec.describe AppKonfig::Config do
  it 'is a Hash' do
    expect(subject).to be_a(Hash)
  end

  it 'loads config based on RAILS_ENV' do
    allow(ENV).to receive(:fetch).and_return('test')
    expect(subject.hostname).to eq('test.example.com')
  end

  it 'uses development config by default' do
    expect(described_class::DEFAULT_ENV).to eq('development')
    expect(subject.hostname).to eq('example.com')
  end

  it 'handles nested keys' do
    expect(subject.proxy.port).to eq(3000)
  end

  it 'merges config from secrets file' do
    allow(ENV).to receive(:fetch).and_return('production')
    expect(subject.hostname).to eq('production.example.com')
    expect(subject.array_key).to eq(['first_new', 'second_new', 'third_new'])
  end

  it 'allows to use a key named "key" in configuration' do
    expect(subject.some_api.key).to eq('secret')
  end

  it 'allows to embed ruby inside a config file' do
    allow(ENV).to receive(:[]).with('SECRET_KEY').and_return('value_from_env')
    expect(subject.secret_key).to eq('value_from_env')
  end

  context 'when secrets file is not found' do
    it 'fails silently' do
      stub_const('AppKonfig::Config::CONFIG_PATH', {
        public: './config/config.yml',
        secret: '',
      })
      expect{ subject }.not_to raise_error
    end
  end
end
