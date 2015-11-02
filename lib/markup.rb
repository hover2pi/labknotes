require 'digest/sha1'
require 'cgi'

class Markup
  def initialize(params)
    @data     = params[:content]
    @format   = params[:format] || "markdown"
    @tagmap   = {}
    @codemap  = {}
    @texmap   = {}
    @premap   = {}
  end

  def render()
    data = extract_tex(@data.dup)
    data = extract_tags(data)

    data = begin
      case @format
      when "markdown" then
        RDiscount.new(data).to_html
      else
        %{<p class="gollum-error">Unknown format: #{@format}</p>}
      end
    rescue Object => e
      %{<p class="gollum-error">#{e.message}</p>}
    end
    data = process_tags(data)
    data = process_tex(data)
    data.gsub!(/<p><\/p>/, '')
    data.html_safe
  end

  #########################################################################
  #
  # TeX
  #
  #########################################################################

  # Extract all TeX into the texmap and replace with placeholders.
  #
  # data - The raw String data.
  #
  # Returns the placeholder'd String data.
  def extract_tex(data)
    data.gsub(/\\\[\s*(.*?)\s*\\\]/m) do
      tag = CGI.escapeHTML($1)
      id  = Digest::SHA1.hexdigest(tag)
      @texmap[id] = [:block, tag]
      id
    end.gsub(/\\\(\s*(.*?)\s*\\\)/m) do
      tag = CGI.escapeHTML($1)
      id  = Digest::SHA1.hexdigest(tag)
      @texmap[id] = [:inline, tag]
      id
    end
  end

  # Process all TeX from the texmap and replace the placeholders with the
  # final markup.
  #
  # data - The String data (with placeholders).
  #
  # Returns the marked up String data.
  def process_tex(data)
    @texmap.each do |id, spec|
      type, tex = *spec
      out =
      case type
        when :block
          %{<script type="math/tex; mode=display">#{tex}</script>}
        when :inline
          %{<script type="math/tex">#{tex}</script>}
      end
      data.gsub!(id, out)
    end
    data
  end

  #########################################################################
  #
  # Tags
  #
  #########################################################################

  # Extract all tags into the tagmap and replace with placeholders.
  #
  # data - The raw String data.
  #
  # Returns the placeholder'd String data.
  def extract_tags(data)
    data.gsub!(/(.?)\[\[(.+?)\]\]([^\[]?)/m) do
      if $1 == "'" && $3 != "'"
        "[[#{$2}]]#{$3}"
      elsif $2.include?('][')
        if $2[0..4] == 'file:'
          pre = $1
          post = $3
          parts = $2.split('][')
          parts[0][0..4] = ""
          link = "#{parts[1]}|#{parts[0].sub(/\.org/,'')}"
          id = Digest::SHA1.hexdigest(link)
          @tagmap[id] = link
          "#{pre}#{id}#{post}"
        else
          $&
        end
      else
        id = Digest::SHA1.hexdigest($2)
        @tagmap[id] = $2
        "#{$1}#{id}#{$3}"
      end
    end
    data
  end

  # Process all tags from the tagmap and replace the placeholders with the
  # final markup.
  #
  # data      - The String data (with placeholders).
  #
  # Returns the marked up String data.
  def process_tags(data)
    @tagmap.each do |id, tag|
      data.gsub!(id, process_tag(tag))
    end
    data
  end

  # Process a single tag into its final HTML form.
  #
  # tag       - The String tag contents (the stuff inside the double
  #             brackets).
  #
  # Returns the String HTML version of the tag.
  def process_tag(tag)
    if html = process_image_tag(tag)
      html
    elsif html = process_file_link_tag(tag)
      html
    end
  end

  # Attempt to process the tag as an image tag.
  #
  # tag - The String tag contents (the stuff inside the double brackets).
  #
  # Returns the String HTML if the tag is a valid image tag or nil
  #   if it is not.
  def process_image_tag(tag)
    parts = tag.split('|')
    return if parts.size.zero?

    name  = parts[0].strip
    path = name if name =~ /^https?:\/\/.+(jpg|png|gif|svg|bmp)$/i

    if path
      opts = parse_image_tag_options(tag)

      containered = false

      classes = [] # applied to whatever the outermost container is
      attrs   = [] # applied to the image

      align = opts['align']
      if opts['float']
        containered = true
        align ||= 'left'
        if %w{left right}.include?(align)
          classes << "float-#{align}"
        end
      elsif %w{top texttop middle absmiddle bottom absbottom baseline}.include?(align)
        attrs << %{align="#{align}"}
      elsif align
        if %w{left center right}.include?(align)
          containered = true
          classes << "align-#{align}"
        end
      end

      if width = opts['width']
        if width =~ /^\d+(\.\d+)?(em|px)$/
          attrs << %{width="#{width}"}
        end
      end

      if height = opts['height']
        if height =~ /^\d+(\.\d+)?(em|px)$/
          attrs << %{height="#{height}"}
        end
      end

      if alt = opts['alt']
        attrs << %{alt="#{alt}"}
      end

      attr_string = attrs.size > 0 ? attrs.join(' ') + ' ' : ''

      if opts['frame'] || containered
        classes << 'frame' if opts['frame']
        %{<span class="#{classes.join(' ')}">} +
        %{<span>} +
        %{<img src="#{path}" #{attr_string}/>} +
        (alt ? %{<span>#{alt}</span>} : '') +
        %{</span>} +
        %{</span>}
      else
        %{<img src="#{path}" #{attr_string}/>}
      end
    end
  end

  # Parse any options present on the image tag and extract them into a
  # Hash of option names and values.
  #
  # tag - The String tag contents (the stuff inside the double brackets).
  #
  # Returns the options Hash:
  #   key - The String option name.
  #   val - The String option value or true if it is a binary option.
  def parse_image_tag_options(tag)
    tag.split('|')[1..-1].inject({}) do |memo, attr|
      parts = attr.split('=').map { |x| x.strip }
      memo[parts[0]] = (parts.size == 1 ? true : parts[1])
      memo
    end
  end

  # Attempt to process the tag as a file link tag.
  #
  # tag       - The String tag contents (the stuff inside the double
  #             brackets).
  #
  # Returns the String HTML if the tag is a valid file link tag or nil
  #   if it is not.
  def process_file_link_tag(tag)
    parts = tag.split('|')
    return if parts.size.zero?

    name  = parts[0].strip
    path  = parts[1] && parts[1].strip
    path = (path =~ %r{^https?://}) ? path : nil

    (name && path) ? %{<a href="#{path}">#{name}</a>} : nil
  end
end
