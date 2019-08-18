# New Feed Blogs

## Requirements

- Ruby
- Selenium
- NodeJS
- Pug

## Installation

```
# install selenium gem
# you need install the driver for browser too. In my case
# I use firefox, so I install geckodriver
$ gem install selenium-webdriver

# install node dependencies
$ npm install
```

## How to use

```
# retrive new articles for the configured blogs
$ ruby scraper/app.rb

# run the serve to see the result
$ node index.js # or nodemon

# go to http://localhost:2000/
```

## How it was done

I set up only two blogs. They are mapped on `blogs.json`. When the ruby script is executed, it is checked the last time it was executed so that it can retrieve the five articles written since this date. The result is saved to `blogs.json`.

When index.js is executed, a view is built, using Pug template, based on articles saved on `blogs.json`.