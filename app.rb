require 'rubygems'
require 'selenium-webdriver'
require 'json'
require 'date'

def main
  return puts 'This script already updated' if already_execute_today?

  last_check_date = seriealize_date(last_check)

  driver = Selenium::WebDriver.for :firefox

  read_file('blogs.json').each_with_index do |blog, blog_index|
    # access blog
    driver.get blog['url']

    # get all first five dates
    created_at = driver.find_elements(css: blog['path_to_created_at']).map(&:text)[0, 5]

    # get all the first five titles and url
    title_and_url = driver.find_elements(css: blog['path_to_title']).map { |result|
      {
        title: result.text,
        url: result.attribute('href')
      }
    }[0, 5]

    new_articles = []

    # loop in all five first articles
    created_at.each_with_index do |date, index|
      if seriealize_date(date) > last_check_date
        new_articles.push({
          title: title_and_url[index][:title],
          url: title_and_url[index][:url]
        })
      end
    end

    write_new_articles(new_articles, blog_index) unless new_articles.empty?

    save_last_check
  end

  driver.quit
end

def read_file(filename)
  JSON.parse(
    File.read(filename, symbolize_names: true)
  )
end

def write_file(hash, filename)
  File.open(filename, 'w') do |f|
    f.write(hash.to_json)
  end
end

def seriealize_date(date)
  month, day, year = date.split(Regexp.union([' ', ', ', '-']))

  Date.parse("#{seriealize_day(day)}-#{seriealize_month(month)}-#{year}")
end

def seriealize_day(day)
  day.length > 1 ? day.delete_suffix('th') : day
end

def seriealize_month(month)
  # check if the month already is a integer
  return month if month.to_i.positive?

  month = month.downcase

  result =
    if %w[january jan].include?(month)
      1
    elsif %w[february feb].include?(month)
      2
    elsif %w[march mar].include?(month)
      3
    elsif %w[april apr].include?(month)
      4
    elsif %w[may may].include?(month)
      5
    elsif %w[june jun].include?(month)
      6
    elsif %w[july jul].include?(month)
      7
    elsif %w[august aug].include?(month)
      8
    elsif %w[september sep].include?(month)
      9
    elsif %w[october oct].include?(month)
      10
    elsif %w[november nov].include?(month)
      11
    elsif %w[december dec].include?(month)
      12
    end

  result
end

def last_check
  read_file('checks.json')[-1]
end

def write_new_articles(articles, blog_index)
  blogs = read_file('blogs.json')
  blogs[blog_index]['articles'] = articles

  write_file(blogs, 'blogs.json')
end

def save_last_check
  checks = read_file('checks.json')

  write_file(checks.push(today), 'checks.json') unless already_execute_today?
end

def already_execute_today?
  last_check == today ? true : false
end

def today
  DateTime.now.strftime('%m-%d-%Y')
end

main
