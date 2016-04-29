require 'spec_helper'

module ChannelGrouping
  describe Destination do
    describe '#medium' do
      subject { Destination.new(url).medium }

      context 'when the url contains a utm_medium' do
        let(:url) { 'http://example.com?utm_medium=some-medium' }

        it 'extracts the utm_medium' do
          expect(subject).to eq 'some-medium'
        end
      end

      context 'when the url contains a utm_medium with a space' do
        let(:url) { 'http://example.com?utm_medium=some%20medium' }

        it 'extracts the utm_medium' do
          expect(subject).to eq 'some medium'
        end
      end

      context 'when the url contains a blank utm_medium' do
        let(:url) { 'http://example.com?utm_medium=&foo=bar' }

        it "returns nil" do
          expect(subject).to eq nil
        end
      end

      context 'when the url does not contain a utm_medium' do
        let(:url) { 'http://example.com?foo=bar' }

        it "returns nil" do
          expect(subject).to eq nil
        end
      end

      context 'when there are no query params' do
        let(:url) { 'http://example.com' }

        it "returns nil" do
          expect(subject).to eq nil
        end
      end
    end

    describe '#host' do
      context 'when the url is present' do
        let(:url) { 'http://some-site.com/some/path' }

        it 'returns the host' do
          expect(Source.new(url).host).to eq 'some-site.com'
        end
      end

      context 'when the url is a blank string' do
        let(:url) { '' }

        it 'returns nil' do
          expect(Source.new(url).host).to be nil
        end
      end

      context 'when the url is invalid' do
        let(:url) { 'http|someinvalidurl?a|b' }

        it 'returns nil' do
          expect(Source.new(url).host).to be nil
        end
      end
    end

  end
end

