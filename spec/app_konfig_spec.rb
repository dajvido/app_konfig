require 'spec_helper'
require 'app_konfig/config'

RSpec.describe AppKonfig::Config do
  context '#get' do
    it 'loads config based on RAILS_ENV' do
      allow(ENV).to receive(:fetch).and_return('test')
      expect(subject.get('hostname')).to eq('test.example.com')
    end

    it 'uses development config by default' do
      expect(described_class::DEFAULT_ENV).to eq('development')
      expect(subject.get('hostname')).to eq('example.com')
    end

    it 'handles nested keys' do
      expect(subject.get('proxy.port')).to eq(3000)
    end

    it 'merges config from secrets file' do
      allow(ENV).to receive(:fetch).and_return('production')
      expect(subject.get('hostname')).to eq('production.example.com')
      expect(subject.get('array_key')).to eq(['first_new', 'second_new', 'third_new'])
    end

    it 'allows to use a configuration names the same as methods from the Hash class' do
      allow(ENV).to receive(:fetch).and_return('production')
      expect(subject.get('keys')).to eq(123456789)
      expect(subject.get('key')).to eq("key")
      expect(subject.get('other.values')).to eq(["first_old", "second_old", "third_old"])
      expect(subject.get('values')).to eq("James Bond")
      expect(subject.get('value')).to eq("")
    end

    it 'raises exception when a configuration key was not found' do
      allow(ENV).to receive(:fetch).and_return('production')
      expect { subject.get('test.test3.test2.test1') }.to raise_error(AppKonfig::ConfigurationKeyNotFound)
    end

    it 'allows to embed ruby inside a config file' do
      allow(ENV).to receive(:[]).with('SECRET_KEY').and_return('value_from_env')
      expect(subject.get('secret_key')).to eq('value_from_env')
    end
  end

  context 'a chain method invoking' do
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

    it 'allows to use a configuration names the same as methods from the Hash class' do
      allow(ENV).to receive(:fetch).and_return('production')
      expect(subject.keys).to eq ["hostname", "key", "keys", "array_key", "other", "values", "value"]
      expect(subject.other.values).to eq([["first_old", "second_old", "third_old"]])
      expect(subject.values).to eq ["production.example.com", "key", 123456789, ["first_new", "second_new", "third_new"], {"values"=>["first_old", "second_old", "third_old"]}, "James Bond", ""]
      expect(subject.value).to eq("")
    end

    it 'allows to embed ruby inside a config file' do
      allow(ENV).to receive(:[]).with('SECRET_KEY').and_return('value_from_env')
      expect(subject.secret_key).to eq('value_from_env')
    end
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
