module Jekyll

  class SnootyConverter < Converter

    def matches(ext)
      ext =~ /^\.snooty$/i
    end

    def output_ext(ext)
      ".html"
    end

    def convert(content)
      content
        .gsub("can't", "cannot")
        .gsub("doesn't", "does not")
        .gsub(" but ", "&mdash;alas!&mdash;")
        .gsub(" so ", " therefore ")
        .gsub("does", "dost")
        .gsub("won't", "will most certainly and assuredly not")
        .gsub("never", "ne'er")
        .gsub(" to", " toward ")
        .gsub("you", "thou")
        .gsub(" me ", " mine")
        .gsub(" has ", " hast ")
        .gsub(". ", "! ")
    end

  end

end