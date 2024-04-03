RSpec.describe HTMLPipeline::HighlightFilter do
  context 'no context' do
    it 'raise error' do
      expect { HTMLPipeline::HighlightFilter.call('dummy') }.to raise_error(/Missing context keys/)
    end
  end

  context 'with string pattern' do
    subject { HTMLPipeline::HighlightFilter.call(text, context: { highlight_pattern: 'Ruby' }).to_s }

    let(:text) { '<div>Rubyは絶妙にバランスのとれた言語です。 Rubyの作者である、Matzことまつもと</div>' }

    it { is_expected.to eq '<div><span class="highlight">Ruby</span>は絶妙にバランスのとれた言語です。 <span class="highlight">Ruby</span>の作者である、Matzことまつもと</div>' }
  end

  context 'with regexp pattern' do
    subject { HTMLPipeline::HighlightFilter.call(text, context: { highlight_pattern: /ruby/i }).to_s }

    let(:text) { '<div>Rubyは絶妙にバランスのとれた言語です。 Rubyの作者である、Matzことまつもと</div>' }

    it { is_expected.to eq '<div><span class="highlight">Ruby</span>は絶妙にバランスのとれた言語です。 <span class="highlight">Ruby</span>の作者である、Matzことまつもと</div>' }
  end

  context 'with class_name context' do
    subject { HTMLPipeline::HighlightFilter.call(text, context: { highlight_pattern: 'Ruby', highlight_class_name: 'lang' }).to_s }

    let(:text) { '<div>Rubyは絶妙にバランスのとれた言語です。 Rubyの作者である、Matzことまつもと</div>' }

    it { is_expected.to eq '<div><span class="lang">Ruby</span>は絶妙にバランスのとれた言語です。 <span class="lang">Ruby</span>の作者である、Matzことまつもと</div>' }
  end

  context 'with converter' do
    subject { HTMLPipeline::HighlightFilter.call(text, context: { highlight_pattern: /(@Matz)(\s?)/i, highlight_converter: ->(matches) { %(<span class="highlight">#{ERB::Util.html_escape(matches[1])}</span>#{matches[2]}) }} ).to_s }

    let(:text) { '<div>@Matz が作ったRubyは絶妙にバランスのとれた言語です。 Rubyの作者である、@Matz ことまつもと</div>' }

    it { is_expected.to eq '<div><span class="highlight">@Matz</span> が作ったRubyは絶妙にバランスのとれた言語です。 Rubyの作者である、<span class="highlight">@Matz</span> ことまつもと</div>' }
  end
end
