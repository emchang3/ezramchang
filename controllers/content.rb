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
    contentParts = ContentHelpers.paginate(content, params, url)

    slim :content, locals: {
      **contentParts,
      style: ContentHelpers.load_css(settings.stylesheet),
      title: 'Posts',
      url: url
    }
  end

  get '/post/:title' do
    title = params['title']
    redirect 404 if title.nil? || title.empty?

    content = ContentHelpers.get_post(settings.content_dir, title)
    redirect 404 if content.length != 1

    parsed_title = title.split('-').join(' ')

    slim :post, locals: {
      content: ContentHelpers.parse_md(content)[0],
      style: ContentHelpers.load_css(settings.stylesheet),
      title: parsed_title,
      url: request.url
    }
  end

  not_found do
    slim :notfound, locals: { **ContentHelpers.nf_404, url: request.url }
  end
end
