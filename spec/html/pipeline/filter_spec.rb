RSpec.describe HTML::Pipeline::HighlightFilter do
  context 'no context' do
    it 'raise error' do
      expect { HTML::Pipeline::HighlightFilter.new('dummy') }.to raise_error(/Missing context keys/)
    end
  end

  context 'with string pattern' do
    subject { HTML::Pipeline::HighlightFilter.new(text, highlight_pattern: 'Ruby').call.to_s }

    let(:text) { 'Rubyは絶妙にバランスのとれた言語です。 Rubyの作者である、Matzことまつもと' }

    it { is_expected.to eq '<span class="highlight">Ruby</span>は絶妙にバランスのとれた言語です。 <span class="highlight">Ruby</span>の作者である、Matzことまつもと' }
  end

  context 'with regexp pattern' do
    subject { HTML::Pipeline::HighlightFilter.new(text, highlight_pattern: /ruby/i).call.to_s }

    let(:text) { 'Rubyは絶妙にバランスのとれた言語です。 Rubyの作者である、Matzことまつもと' }

    it { is_expected.to eq '<span class="highlight">Ruby</span>は絶妙にバランスのとれた言語です。 <span class="highlight">Ruby</span>の作者である、Matzことまつもと' }
  end

  context 'with class_name context' do
    subject { HTML::Pipeline::HighlightFilter.new(text, highlight_pattern: 'Ruby', highlight_class_name: 'lang').call.to_s }

    let(:text) { 'Rubyは絶妙にバランスのとれた言語です。 Rubyの作者である、Matzことまつもと' }

    it { is_expected.to eq '<span class="lang">Ruby</span>は絶妙にバランスのとれた言語です。 <span class="lang">Ruby</span>の作者である、Matzことまつもと' }
  end

  context 'with converter' do
    subject { HTML::Pipeline::HighlightFilter.new(text, highlight_pattern: /(@Matz)(\s?)/i, highlight_converter: ->(matches) { %(<span class="highlight">#{ERB::Util.html_escape(matches[1])}</span>#{matches[2]}) } ).call.to_s }

    let(:text) { '@Matz が作ったRubyは絶妙にバランスのとれた言語です。 Rubyの作者である、@Matz ことまつもと' }

    it { is_expected.to eq '<span class="highlight">@Matz</span> が作ったRubyは絶妙にバランスのとれた言語です。 Rubyの作者である、<span class="highlight">@Matz</span> ことまつもと' }
  end
end
