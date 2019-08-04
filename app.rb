require 'rubygems'
require 'selenium-webdriver'
require 'json'

# https://sebastiandedeyne.com/
# https://stitcher.io/
# https://www.joelonsoftware.com/

# - recuperar esse tempo e verificar há algo novo
# - se tiver, salvar em um json os novos textos
# - Criar um html para ler esse json

def main
  driver = Selenium::WebDriver.for :firefox

  read_blogs.each do |blog|
    driver.get blog['url']

    elements = driver.find_elements(css: blog['css']).map(&:text)

    puts elements
  end

  driver.quit

end

def read_blogs
  file = File.read('blogs.json')
  JSON.parse(file)
end

main()