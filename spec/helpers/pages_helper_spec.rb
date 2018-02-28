require 'rails_helper'

RSpec.describe PagesHelper, type: :helper do
  describe "#markdown_to_html" do
    context "markdown bold" do
      let(:examples) {{
        "**word**" =>
          "<b>word</b>",

        "text **with** multiple **occurences**" =>
          "text <b>with</b> multiple <b>occurences</b>",

        "bold in \\\\**italic**\\\\" =>
          "bold in <i><b>italic</b></i>",

        "bold ((in[**link**]))" =>
          "bold <a href=in><b>link</b></a>",
      }}

      it "transforms **string** into <b>string</b>" do
        examples.each do |original, result|
          expect(markdown_to_html(original)).to eql(result)
        end
      end
    end

    context "markdown italic" do
      let(:examples) {{
        "\\\\word\\\\" => 
          "<i>word</i>",

        "text \\\\with\\\\ multiple \\\\occurences\\\\" => 
          "text <i>with</i> multiple <i>occurences</i>",

        "italic in **\\\\bold\\\\** string" =>
          "italic in <b><i>bold</i></b> string",

        "italic ((p1/p2/p3[\\\\link\\\\])) string" =>
          "italic <a href=p1/p2/p3><i>link</i></a> string",
      }}

      it "transforms \\\\string\\\\ into <i>string</i>" do
        examples.each do |original, result|
          expect(markdown_to_html(original)).to eql(result)
        end
      end
    end

    context "markdown link" do
      let(:examples) {{
        "((some/url/with[text]))" => 
          "<a href=some/url/with>text</a>",

        "text with ((p1/p2/p3[string])) multiple ((url1/with1[occurences]))" => 
          "text with <a href=p1/p2/p3>string</a> multiple <a href=url1/with1>occurences</a>",

        "link in **((p1/p2/p3[bold]))** string" =>
          "link in <b><a href=p1/p2/p3>bold</a></b> string",

        "link in \\\\((p1/p2/p3[italic]))\\\\ string" =>
          "link in <i><a href=p1/p2/p3>italic</a></i> string",
      }}

      it "transforms ((path[string])) into <a href=path>string</a>" do
        examples.each do |original, result|
          expect(markdown_to_html(original)).to eql(result)
        end
      end
    end
  end
end
