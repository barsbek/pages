module PagesHelper
  def html_to_markdown(html)
    html.to_s
      .gsub(/<b>(.+)<\/b>/) { "**#{$1}**" }
      .gsub(/<i>(.+)<\/i>/) { "\\\\#{$1}\\\\" }
      .gsub(/<a.+href\=https?:\/\/[^\/]+\/(\S+)>(.+)<\/a>/) do
        "((#{$1}[#{$2}]))"
      end
  end
end
