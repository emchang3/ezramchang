# frozen_string_literal: true

puts "\tController: Content"

class ContentController < Sinatra::Base
  set :content_dir, "#{$root}/content"
  set :stylesheet, 'content'
  set :public_folder, $assets_root
  set :views, $views

  get '/' do
    content = ContentHelpers.get_content(settings.content_dir)
    redirect 404 if content.empty?

    url = request.url

    ContentHelpers.time_sort(content)
    content_parts = ContentHelpers.paginate(content, params, url)

    slim :content, locals: {
      **content_parts,
      style: ContentHelpers.load_css(settings.stylesheet),
      title: 'Tides of Change',
      description: 'Shower Thoughts of a Self-Proclaimed Sane Man',
      url: url
    }
  end

  get '/post/:title' do
    title = params['title']
    redirect 404 if title.nil? || title.empty?

    content = ContentHelpers.get_post(settings.content_dir, title)
    redirect 404 if content.length != 1

    parsed_title = title.split('-').map(&:capitalize).join(' ')

    slim :post, locals: {
      content: ContentHelpers.parse_md(content)[0],
      style: ContentHelpers.load_css(settings.stylesheet),
      title: parsed_title,
      description: "Thoughts about #{parsed_title}",
      url: request.url
    }
  end

  not_found do
    slim :notfound, locals: {
      **ContentHelpers.nf_404,
      description: 'Lost the plot, have you?',
      url: request.url
    }
  end
end
