module Jekyll

  class AllArtistPage < Page

    def initialize(site, artists)
      @site = site
      self.ext = '.html'
      self.basename = 'all-artists'
      self.content = <<-EOS
        <h3>{{ page.title }}</h3>
        <ul class="posts">
          {% for artist in page.artists %}
            <li>{{ artist }}</li>
          {% endfor %}
        </ul>
      EOS

      self.data = {
        'layout' => 'default',
        'title' => 'All Artists',
        'artists' => artists
      }
    end

    def render(layouts, site_payload)
      payload = {
        "page" => self.to_liquid,
        "paginator" => pager.to_liquid
      }.deep_merge(site_payload)
      do_layout(payload, layouts)
    end

    def url
      File.join("/", "all-artists.html")
    end

    def to_liquid
      self.data.deep_merge({
          "url" => self.url,
          "content" => self.content
        })
    end

    def write(dest_prefix, dest_suffix = nil)
      dest = dest_prefix
      dest = File.join(dest, dest_suffix) if dest_suffix
      FileUtils.mkdir_p(dest)
      # The url needs to be unescaped in order to preserve the correct filename
      path = File.join(dest, CGI.unescape(self.url))
      FileUtils.mkdir_p(File.dirname(path))
      File.open(path, "w") do |f|
        f.write(self.output)
      end
    end

    def html?
      true
    end

  end

  class AllArtistPageGenerator < Generator

    def generate(site)
      artists = Array.new
      for post in site.posts
        artists.push(post.data['artist']) unless artists.include?(post.data['artist'])
      end
      site.pages << AllArtistPage.new(site, artists)
    end

  end

end