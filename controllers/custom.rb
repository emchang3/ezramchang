# frozen_string_literal: true

puts "\tController: Custom"

class CustomController < Sinatra::Base
  set :public_folder, $assets_root
  set :views, $views

  routes = YAML.load_file("#{$root}/customlist.yml")

  routes.each do |route|
    name = route['name']
    path = route['path']
    puts "		#{path}: #{name}"

    get path do
      folder = "#{$root}/#{name}"

      content = route['content'].map { |section| "#{folder}/#{section}" }
      fallback = route['fallback'].map { |section| "#{folder}/#{section}" }

      slim name.to_sym, locals: {
        content: ContentHelpers.parse_md(content),
        description: route['description'],
        fallback: ContentHelpers.parse_md(fallback),
        style: ContentHelpers.load_css(name),
        title: route['title'],
        url: request.url
      }
    end
  end

  get '/robots.txt' do
    send_file File.join(settings.public_folder, 'robots.txt')
  end

  get '/favicon.ico' do
    send_file File.join(settings.public_folder, 'images', 'favicon.ico')
  end

  not_found do
    slim :notfound, locals: {
      **ContentHelpers.nf_404,
      description: 'Lost the plot, have you?',
      url: request.url
    }
  end
end
