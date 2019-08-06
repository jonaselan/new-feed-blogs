require 'rubygems'
require 'selenium-webdriver'
require 'json'
require 'date'

# https://sebastiandedeyne.com/
# https://stitcher.io/
# https://www.joelonsoftware.com/

# - recuperar esse tempo e verificar há algo novo
# - se tiver, salvar em um json os novos textos
# - Criar um html para ler esse json

def main
  driver = Selenium::WebDriver.for :firefox

  read_blogs.each do |blog|
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

    # TODO: The parameter for the condition is the current date.
    # Maybe it would be better to retrieve the last date this script was run
    d = DateTime.now
    d.strftime("%d-%m-%Y")
    created_at.each_with_index do |date, index|
      if seriealize_date(date) > Date.parse("3-08-2019")
        puts title_and_url[index][:title]
        # puts title_and_url[index][:link]
      end
    end
  end

  driver.quit
end

def read_blogs
  file = File.read('blogs.json')

  JSON.parse(file)
end

def seriealize_date(date)
  month, day, year = date.split(Regexp.union([' ', ', ']))

  Date.parse("#{seriealize_day(day)}-#{seriealize_month(month)}-#{year}")
end

def seriealize_day(day)
  day.length > 1 ? day.delete_suffix('th') : day
end

def seriealize_month(month)
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

main()